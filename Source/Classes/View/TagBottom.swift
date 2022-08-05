//
//  TagBottom.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 04/07/22.
//

import UIKit

public class TagBottom: UILabel {
    
    let topInset: CGFloat = 8.0
    let bottomInset: CGFloat = 8.0
    let leftInset: CGFloat = 8.0
    let rightInset: CGFloat = 9.0
      
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
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return addInsets(to: super.sizeThatFits(size))
    }

    public override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: self.bounds.height/2, height: self.bounds.height/2))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        drawText(in: rect)
    }

        
    private func addInsets(to size: CGSize) -> CGSize {
        let width = size.width + leftInset + rightInset
        let height = size.height + topInset + bottomInset - 6
        return CGSize(width: width, height: height)
    }
    
}
