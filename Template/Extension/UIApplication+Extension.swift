import UIKit

extension UIApplication {

    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let presented = controller?.presentedViewController {
            if let navigationController = presented as? UINavigationController {
                return topViewController(controller: navigationController.visibleViewController)
            }
            return topViewController(controller: presented)
        }
        return controller
    }
}
