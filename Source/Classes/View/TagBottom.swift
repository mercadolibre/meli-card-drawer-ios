//
//  TagBottom.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 04/07/22.
//

import UIKit

class TagBottom: UIView {
    
    private var message: Text?
    
    private weak var label: UILabel! = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init(message: Text) {
        super.init(frame: CGRect.zero)
        self.message = message
        render()
    }
    
    private func render() {
        guard let message = message else {
            return
        }
        label.text = message.message
        if let textColor = message.textColor {
            label.textColor = UIColor.fromHex(textColor)
        }
        if let backgroundColor = message.backgroundColor {
            self.backgroundColor = UIColor.fromHex(backgroundColor)
        }
        self.addSubview(label)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 8)
        ])
        self.sizeToFit()
        let path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: self.frame.width/2, height: self.frame.width/2))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
