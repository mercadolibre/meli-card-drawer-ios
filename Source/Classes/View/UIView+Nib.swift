import UIKit

internal extension UIView {
    func loadFromNib() {
        guard let view = MLCardDrawerBundle.bundle().loadNibNamed(String(describing: type(of: self)),
                                                                  owner: self,
                                                                  options: nil)?[0] as? UIView else { return }
        view.frame = bounds
        self.addSubview(view)
    }
}
