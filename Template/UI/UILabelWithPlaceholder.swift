import UIKit

@IBDesignable
/// プレースホルダー付きUILabel
class UILabelWithPlaceholder: UILabel {
    
    let placeHolderColor = UIColor(hex: "123456") // 任意の色指定
    /// プレースホルダー
    @IBInspectable var placeHolder: String = "" {
        didSet {
            self.text = self.placeHolder
            self.sizeToFit()
            self.textColor = self.placeHolderColor
            self.backgroundColor = .clear
        }
    }
    
    override public var text: String? {

        didSet {
            if text!.isEmpty {
                text = placeHolder
                textColor = self.placeHolderColor
            } else {
                self.textColor = .darkText
            }
        }
    }
}
