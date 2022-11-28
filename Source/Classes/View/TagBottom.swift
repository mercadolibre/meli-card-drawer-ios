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
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        drawText(in: rect)
    }

        
    private func addInsets(to size: CGSize) -> CGSize {
        let width = size.width + leftInset + rightInset
        let height = size.height + topInset + bottomInset - 6
        return CGSize(width: width, height: height)
    }
    
}
