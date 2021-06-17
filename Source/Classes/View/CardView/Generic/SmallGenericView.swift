//
//  SmallGenericView.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 16/06/21.
//

import UIKit

class SmallGenericView: GenericView {
    
    @IBOutlet var distanceToLimit: [NSLayoutConstraint]!
    @IBOutlet var imageBorderSize: [NSLayoutConstraint]!
    
    var type: MLCardDrawerType = .large
    
    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        
        if type == .small {
            distanceToLimit.forEach { $0.constant = 6 }
            imageBorderSize.forEach { $0.constant = 10 }
        }
    }
    
}
