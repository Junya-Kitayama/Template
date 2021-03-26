import UIKit
import CoreData

class CoreDataManager: NSObject {

    enum EntityType {
        case test // 適宜指定
        
        var name: String {
            switch self {
            case .test:
                return "test"
            }
        }
    }
    
    let dataModel = "DataModel" // 適宜指定
    
    static let shared = CoreDataManager {}
    
    private(set) var context: NSManagedObjectContext!
    
    init(completionClosure: @escaping () -> Void) {
        let persistentContainer = NSPersistentContainer(name: dataModel)
        context = persistentContainer.viewContext
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }

    func create(entity: EntityType) -> NSManagedObject {
        NSEntityDescription.insertNewObject(forEntityName: entity.name, into: context)
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

    func delete(object: NSManagedObject) {
        context.delete(object)
    }

    private func createRequest(entity: EntityType, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name)

        if let predicate = predicate {
            request.predicate = predicate
        }
        
        if let sortDescriptors = sortDescriptors {
            request.sortDescriptors = sortDescriptors
        }
        return request
    }
    
//    func fetchTest(entity: EntityType, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Test] {
//
//        let request = createRequest(entity: .test, predicate: predicate, sortDescriptors: sortDescriptors)
//
//        do {
//            return try context.fetch(request) as! [Test]
//        } catch {
//            return []
//        }
//    }
}
