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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    private struct Sizes {
        static let titleFont: CGFloat = 14
        static let subtitleFont: CGFloat = 14
        static let descriptionFont: CGFloat = 12
        static let tagFont: CGFloat = 12
        static let imageContainerBorderWith: CGFloat = 2
    }
    
    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool, customLabelFontName: String?) {
        self.frame = frame
        layer.masksToBounds = true
        layer.isDoubleSided = false
        loadFromNib()
        descriptionLabel.isHidden = true 
        setupUI(cardUI)
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
    }
    
    func setupUI(_ cardUI: CardUI) {
        if let genericUI = cardUI as? GenericCardUI {
            backgroundColor = genericUI.cardBackgroundColor

            setTitle(with: genericUI)
            setSubtitle(with: genericUI)
            
            if let gradientColors = genericUI.gradientColors?.map({ UIColor.fromHex($0).cgColor }) {
                addGradientLayer(colors: gradientColors)
            }
            
            setDescription(with: genericUI)
            setHighlightLabel(with: genericUI)            
            setPaymentMethodImage(genericUI)
        }
        
        layer.masksToBounds = true
        setImageContainer()
    }
    
    private func setTitle(with genericUI: GenericCardUI) {
        titleLabel.text = genericUI.titleName
        titleLabel.font = genericUI.titleWeight.getFont(size: Sizes.titleFont)
        titleLabel.textColor = UIColor.fromHex(genericUI.titleTextColor)
    }
    
    private func setSubtitle(with genericUI: GenericCardUI) {
        subtitleLabel.text = genericUI.subtitleName
        subtitleLabel.font = genericUI.subtitleWeight.getFont(size: Sizes.subtitleFont)
        subtitleLabel.textColor = UIColor.fromHex(genericUI.subtitleTextColor)
    }
    
    private func addGradientLayer(colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        
        gradientView.layer.insertSublayer(gradient, at: 0)
        gradient.colors = colors
        gradient.startPoint =  CGPoint(x: 0.1, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0)
    }
    
    private func setDescription(with genericUI: GenericCardUI) {
        guard let name = genericUI.descriptionName, let weight = genericUI.descriptionWeight, let descriptionTextColor = genericUI.descriptionTextColor else {
            return
        }
        
        descriptionLabel.isHidden = false
        descriptionLabel.text = name
        descriptionLabel.font = weight.getFont(size: Sizes.descriptionFont)
        descriptionLabel.textColor = UIColor.fromHex(descriptionTextColor)
    }
    
    private func setHighlightLabel(with genericUI: GenericCardUI) {
        highlightLabel.layer.masksToBounds = true
        highlightLabel.isHidden = genericUI.labelName.isEmpty
        highlightLabel.text = genericUI.labelName
        highlightLabel.font = genericUI.labelWeight.getFont(size: Sizes.tagFont)
        highlightLabel.textColor = UIColor.fromHex(genericUI.labelTextColor)
        highlightLabel.backgroundColor = UIColor.fromHex(genericUI.labelBackgroundColor)
        let path = UIBezierPath(roundedRect: highlightLabel.bounds,
                                byRoundingCorners: [.bottomLeft],
                                cornerRadii: CGSize(width: highlightLabel.frame.height/2,
                                                    height: highlightLabel.frame.height/2))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        highlightLabel.layer.mask = mask
    }
    
    private func setImageContainer() {
        imageContainerView.layer.borderWidth = Sizes.imageContainerBorderWith
        imageContainerView.backgroundColor = .white
        imageContainerView.layer.borderColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1).cgColor
    }
    
    private func setPaymentMethodImage(_ cardUI: GenericCardUI) {
        imageView.image = nil
        UIImageView().getRemoteImage(imageUrl: cardUI.logoImageURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = image
                self.imageView.contentMode = .scaleAspectFit
                self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
                self.imageView.clipsToBounds = true
                self.imageContainerView.layer.cornerRadius = self.imageContainerView.frame.height/2
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
    
    func setupAnimated(_ cardUI: CardUI) {
        
    }
}
