//
//  TagBottom.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 04/07/22.
//

import UIKit

public class TagBottom: UILabel {
    
    let topInset: CGFloat = Constants.Layout.S_MARGIN
    let bottomInset: CGFloat = Constants.Layout.XXS_MARGIN
    let leftInset: CGFloat = Constants.Layout.M_MARGIN
    let rightInset: CGFloat = Constants.Layout.M_MARGIN
      
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
