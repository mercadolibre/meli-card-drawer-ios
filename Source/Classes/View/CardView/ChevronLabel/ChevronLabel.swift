//
//  ChevronLabel.swift
//  MLCardDrawer
//
//  Created by JONATHAN DANIEL BANDONI on 09/12/2019.
//

import Foundation

class ChevronLabel: UILabel {
    
    fileprivate let chevronImage = UIImage(named: "Chevron", in: Bundle(for: ChevronLabel.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    
    fileprivate var formatter = Mask(pattern: [])
    fileprivate var typeFont: Font = Light(shadow: false)
    
    func setup(_ textType: Font?) {
        typeFont = textType ?? Light(shadow: false)
        addAttributes()
    }
    
    fileprivate func addAttributes() {
        guard let image = chevronImage else { return }
        
        let attributes = NSMutableAttributedString()

        textColor = typeFont.color
        let color = typeFont.gradient.getGradient(frame)
        let imageAttribute = NSTextAttachment()
        imageAttribute.image = image
        attributes.append(formatter.format(" ", typeFont, totalPad(), color))
        attributes.append(NSAttributedString(attachment: imageAttribute))
        attributes.addAttributes(formatter.editAtributes(typeFont, typeFont.gradient.getGradient(frame)), range: NSMakeRange(0, 1))
        
        self.attributedText = attributes
    }
    
    fileprivate func totalPad() -> Int {
        return Int(frame.width / font.size(" ").width)
    }
}
