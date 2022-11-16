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


extension UIView {
    public func roundCorners(cornerRadiuns: CGFloat, typeCorners: CACornerMask) {
        self.layer.cornerRadius = cornerRadiuns
        self.layer.maskedCorners = typeCorners
    }
}


extension CACornerMask {
    static public let lowerRigth: CACornerMask = .layerMaxXMaxYCorner
    static public let lowerLeft: CACornerMask = .layerMinXMaxYCorner
    static public let topRight: CACornerMask = .layerMaxXMinYCorner
    static public let topLeft: CACornerMask = .layerMinXMinYCorner
}


extension UIView {
    
    public func bottomTagAlignment(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
