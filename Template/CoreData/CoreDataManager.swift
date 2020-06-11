import UIKit
import CoreData

class CoreDataManager: NSObject {

    enum DataModelType: String {
        case dataModel = "DataModel" // 適宜指定
        
        enum EntityType: String {
            case test = "Test" // 適宜指定
        }
    }

    static let shared = CoreDataManager(dataModel: .dataModel) {}
    private(set) var context: NSManagedObjectContext!
    
    init(dataModel: DataModelType, completionClosure: @escaping () -> Void) {
        let persistentContainer = NSPersistentContainer(name: dataModel.rawValue)
        context = persistentContainer.viewContext
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }

    func create(entity: DataModelType.EntityType) -> NSManagedObject {
        NSEntityDescription.insertNewObject(forEntityName: entity.rawValue, into: context)
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    // 引数オブジェクトのデータを削除
    func delete(object: NSManagedObject) {
        context.delete(object)
    }

    // 一括削除
    // predicateの指定がない場合は指定Entityデータを全て削除
    func deleteContext(entity: DataModelType.EntityType,
                       predicate: NSPredicate?) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        if predicate != nil { request.predicate = predicate }

        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            results.forEach {
                context.delete($0)
            }
        } catch let error as NSError {
            print("FETCH ERROR:\(error.localizedDescription)")
        }
    }

    func fetch(entity: DataModelType.EntityType,
               predicate: NSPredicate?,
               sortDescriptors: [NSSortDescriptor]?) -> [NSManagedObject] {

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)

        if let predicate = predicate { request.predicate = predicate }
        if let sortDescriptors = sortDescriptors { request.sortDescriptors = sortDescriptors }

        do {
            return try context.fetch(request) as! [NSManagedObject]
        } catch {
            return []
        }
    }
}
