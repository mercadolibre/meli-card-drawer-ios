//
//  GenericView.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 28/04/21.
//

import UIKit

public class GenericView: UIView, BasicCard  {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool, customLabelFontName: String?) {
        self.frame = frame
        layer.masksToBounds = true
        layer.isDoubleSided = false
        loadFromNib()
        setupUI(cardUI)
    }
    
    func setupUI(_ cardUI: CardUI) {
        if let genericUI = cardUI as? GenericCardUI {
            backgroundColor = genericUI.cardBackgroundColor
            layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
//            titleLabel.text = genericUI.titleName
//            subtitleLabel.text = genericUI.subtitleName
        }
    }
    
    func isShineEnabled() -> Bool {
        return false
    }
    
    func addShineView() {
        
    }
    
    func removeShineView() {
        
    }
    
    func removeGradient() {
        
    }
    
    func addGradient() {
        
    }
    
    func setupAnimated(_ cardUI: CreditCardUI) {
        
    }
}
