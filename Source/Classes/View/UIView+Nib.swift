import UIKit

internal extension UIView {
    func loadFromNib() {
        let nibName = String(describing: type(of: self))
        guard let view = MLCardDrawerBundle.bundle().loadNibNamed(nibName,
                                                                  owner: self,
                                                                  options: nil)?[0] as? UIView else { return }
        view.frame = bounds
        self.addSubview(view)
    }
}
