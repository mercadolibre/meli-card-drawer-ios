//
//  GenericView.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 28/04/21.
//

import UIKit

public class GenericView: UIView, BasicCard  {
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var highlightLabel: UILabel!
    
    
    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool, customLabelFontName: String?) {
        self.frame = frame
        layer.masksToBounds = true
        layer.isDoubleSided = false
        loadFromNib()
        setupUI(cardUI)
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
    }
    
    func setupUI(_ cardUI: CardUI) {
        
        if let genericUI = cardUI as? GenericCardUI {
            backgroundColor = genericUI.cardBackgroundColor
            
            titleLabel.text = genericUI.titleName
            titleLabel.font = genericUI.titleWeight.getFont()
            titleLabel.textColor = UIColor.fromHex(genericUI.titleTextColor)
            
            subtitleLabel.text = genericUI.subtitleName
            subtitleLabel.font = genericUI.subtitleWeight.getFont(size: 14)
            subtitleLabel.textColor = UIColor.fromHex(genericUI.subtitleTextColor)
            
            highlightLabel.isHidden = genericUI.labelName.isEmpty
            highlightLabel.text = genericUI.labelName
            highlightLabel.font = genericUI.labelWeight.getFont(size: 14)
            highlightLabel.textColor = UIColor.fromHex(genericUI.labelTextColor)
            highlightLabel.backgroundColor = UIColor.fromHex(genericUI.labelBackgroundColor)
            let path = UIBezierPath(roundedRect: highlightLabel.bounds,
                                    byRoundingCorners: [.bottomLeft],
                                    cornerRadii: CGSize(width: highlightLabel.frame.height/2,
                                                        height: highlightLabel.frame.height/2))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            highlightLabel.layer.mask = mask
            
            setPaymentMethodImage(genericUI)
        }
        
        layer.masksToBounds = true
        imageContainerView.layer.borderWidth = 2
        imageContainerView.layer.borderColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1).cgColor
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height/2
    }
    
    private func setPaymentMethodImage(_ cardUI: GenericCardUI) {
        imageView.image = nil
        UIImageView().getRemoteImage(imageUrl: cardUI.logoImageURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = image
                self.imageView.contentMode = .scaleAspectFit
            }
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
