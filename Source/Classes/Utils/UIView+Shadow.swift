//
//  UIView+Shadow.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 29/03/21.
//

extension UIView {
    func addInnerShadow() {
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        
        let radius = self.frame.size.height/2
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -3, dy: -3), cornerRadius: radius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius: radius).reversing()
        path.append(cutout)
        
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 3)
        innerShadow.shadowOpacity = 0.35
        innerShadow.shadowRadius = 3
        innerShadow.cornerRadius = self.frame.size.height/2
        layer.addSublayer(innerShadow)
        
        layer.masksToBounds = true
    }
}
