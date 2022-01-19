//
//  MediumGenericView.swift
//  MLCardDrawer-MLCardDrawerResources
//
//  Created by Gisela Araceli Ramos Carrasco on 17/12/2021.
//

import UIKit

public class MediumGenericView: UIView, BasicCard {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var highlightLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private struct FontSizes {
        static let title: CGFloat = 14
        static let subtitle: CGFloat = 14
        static let description: CGFloat = 12
        static let badge: CGFloat = 11
    }
    
    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool, customLabelFontName: String?) {
        self.frame = frame
        layer.masksToBounds = true
        layer.isDoubleSided = false
        loadFromNib()
        descriptionLabel.isHidden = true
        setupUI(cardUI)
        addGradient()
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
    }
    
    func setupUI(_ cardUI: CardUI) {
        if let genericUI = cardUI as? GenericCardUI {
            setTitle(with: genericUI)
            setSubtitle(with: genericUI)
            
            if let gradientColors = genericUI.gradientColors?.map({ UIColor.fromHex($0).cgColor }) {
                addGradientLayer(colors: gradientColors)
            }
            
            if genericUI.descriptionName != nil {
                setDescription(with: genericUI)
            }
        
            backgroundColor = genericUI.cardBackgroundColor
            
            setHighlightLabel(with: genericUI)
            
            setPaymentMethodImage(genericUI)
        }
        
        layer.masksToBounds = true
        setImageContainer()
    }
    
    private func setImageContainer() {
        imageContainerView.layer.borderWidth = 2
        imageContainerView.backgroundColor = .white
        imageContainerView.layer.borderColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1).cgColor
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height/2
    }
    
    private func setTitle(with genericUI: GenericCardUI) {
        titleLabel.text = genericUI.titleName
        titleLabel.font = genericUI.titleWeight.getFont(size: FontSizes.title)
        titleLabel.textColor = UIColor.fromHex(genericUI.titleTextColor)
    }
    
    private func setSubtitle(with genericUI: GenericCardUI) {
        subtitleLabel.text = genericUI.subtitleName
        subtitleLabel.font = genericUI.subtitleWeight.getFont(size: FontSizes.subtitle)
        subtitleLabel.textColor = UIColor.fromHex(genericUI.subtitleTextColor)
    }
    
    private func setDescription(with genericUI: GenericCardUI) {
        descriptionLabel.isHidden = false
        descriptionLabel.text = genericUI.descriptionName
        descriptionLabel.font = genericUI.descriptionWeight?.getFont(size: FontSizes.description)
        if let descriptionTextColor = genericUI.descriptionTextColor {
            descriptionLabel.textColor = UIColor.fromHex(descriptionTextColor)
        }
    }
    
    private func addGradientLayer(colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        gradient.colors = colors
        gradientView.layer.insertSublayer(gradient, at: 0)
        gradient.startPoint =  CGPoint(x: 0.1, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0)
    }
    
    private func setHighlightLabel(with genericUI: GenericCardUI) {
        highlightLabel.layer.masksToBounds = true
        highlightLabel.isHidden = genericUI.labelName.isEmpty
        highlightLabel.text = genericUI.labelName
        highlightLabel.font = genericUI.labelWeight.getFont(size: FontSizes.badge)
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
    
    private func setPaymentMethodImage(_ cardUI: GenericCardUI) {
        imageView.image = nil
        UIImageView().getRemoteImage(imageUrl: cardUI.logoImageURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = image
                self.imageView.contentMode = .scaleAspectFit
                self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
                self.imageView.clipsToBounds = true
            }
        }
    }
    
    func isShineEnabled() -> Bool {
        false
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
