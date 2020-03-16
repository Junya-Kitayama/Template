import UIKit

protocol StoryboardInstantiable {}

enum StoryboardName: String {
    case indicator = "IndicatorView"
}

extension StoryboardInstantiable where Self: UIViewController {
    static func instantiate(name: StoryboardName) -> Self? {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self
        return controller
    }
}
