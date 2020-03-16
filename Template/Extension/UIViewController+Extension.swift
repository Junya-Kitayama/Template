import UIKit

extension UIViewController {

    func showAlertDialog(title: AlertTitle,
                         message: AlertMessage,
                         okButtonTitle: AlertButtonTitle = AlertButtonTitle.ok,
                         cancelButtonTitle: AlertButtonTitle? = nil,
                         cancelFunc: (() -> Void)? = nil,
                         okFunc: (() -> Void)? = nil) {

        DispatchQueue.main.async {
            let alert = UIAlertController(title: title.getMessage(), message: message.getMessage(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: okButtonTitle.rawValue, style: .default) { _ in
                if let okFunc = okFunc { okFunc() }
            }

            if let cancelButtonTitle = cancelButtonTitle {
                let cancelAction = UIAlertAction(title: cancelButtonTitle.rawValue, style: .default) { _ in
                    if let cancelFunc = cancelFunc { cancelFunc() }
                }
                alert.addAction(cancelAction)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    func showIndicator(message: String = "", completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            if !message.isEmpty {
                Common.shared.indicator.setMessage(message: message)
            }
            Common.shared.indicator.modalTransitionStyle = .crossDissolve
            Common.shared.indicator.modalPresentationStyle = .overCurrentContext
            self.present(Common.shared.indicator, animated: true) {
                completion()
            }
        }
    }

    func dismissIndicator(completion: (() -> Void)?=nil) {
        DispatchQueue.main.async {
            if let presented = self.presentedViewController,
                presented as? IndicatorViewController != nil {

                Common.shared.indicator.dismiss(animated: true) {
                    if completion != nil {
                        completion?()
                    }
                }
            }
        }
    }
}
