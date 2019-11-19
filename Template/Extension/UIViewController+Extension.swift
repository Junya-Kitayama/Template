import UIKit

extension UIViewController {

    func showAlertDialog(title: String,
                         message: String,
                         positiveButtonTitle: String,
                         negativeButtonTitle: String?,
                         positiveButtonFunc: (() -> Void)?) {

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let positiveAction = UIAlertAction(title: positiveButtonTitle, style: .default) { _ in
            if let positiveButtonFunc = positiveButtonFunc { positiveButtonFunc() }
        }

        if let negativeButtonTitle = negativeButtonTitle {
            let negativeAction = UIAlertAction(title: negativeButtonTitle, style: .default)
            alert.addAction(negativeAction)
        }
        alert.addAction(positiveAction)
        present(alert, animated: true, completion: nil)
    }
}
