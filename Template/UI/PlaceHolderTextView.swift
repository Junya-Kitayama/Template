import UIKit

@IBDesignable
class PlaceHolderTextView: UITextView {

    // MARK: Stored Instance Properties

    var placeHolder: String = "" {
        didSet {
            self.placeHolderLabel.text = placeHolder
            self.placeHolderLabel.sizeToFit()
        }
    }

    lazy var placeHolderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 6.0, y: 6.0, width: 0.0, height: 0.0))
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = self.font
        label.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.098_039_2, alpha: 0.22)
        label.backgroundColor = .clear
        self.addSubview(label)
        return label
    }()

    // MARK: Initializers

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: View Life-Cycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeVisiblePlaceHolder),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }

    @objc
    func changeVisiblePlaceHolder() {
        self.placeHolderLabel.alpha = (self.placeHolder.isEmpty || !self.text.isEmpty) ? 0.0 : 1.0
    }
}
