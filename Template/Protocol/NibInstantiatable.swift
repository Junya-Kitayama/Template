import UIKit

protocol NibInstantiatable {
    static var nibName: String { get }
    
    static func instantiateFromNib(withOwner: AnyObject?, options: [UINib.OptionsKey: AnyObject]?) -> UIView
}

extension NibInstantiatable where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }

    static func instantiateFromNib(withOwner: AnyObject?, options: [UINib.OptionsKey: AnyObject]?) -> UIView {
        guard let nib = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: withOwner, options: options).first as? UIView else {
            fatalError("invalid nib name")
        }
        return nib
    }
}
