//
//  TagBottom.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 04/07/22.
//

import UIKit

public class TagBottom: UILabel {
    
    let topInset: CGFloat = 7.0
    let bottomInset: CGFloat = 5.0
    let leftInset: CGFloat = 8.0
    let rightInset: CGFloat = 8.0
      
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    public override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
    
    public override func didMoveToWindow() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: self.bounds.height/2, height: self.bounds.height/2))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
