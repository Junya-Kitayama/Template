import Foundation

class Common: NSObject {

    static let shared = Common()

    lazy var indicator: IndicatorViewController = {
        return IndicatorViewController.instantiate(name: .indicator)!
    }()

    override private init() {}
}
