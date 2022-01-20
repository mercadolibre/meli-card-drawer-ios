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
    @IBOutlet weak var highlightContainerView: UIView!
    
    private var model: GenericCardUI?
    
    private struct Sizes {
        static let titleFont: CGFloat = 14
        static let subtitleFont: CGFloat = 14
        static let descriptionFont: CGFloat = 12
        static let tagFont: CGFloat = 12
        static let imageContainerBorderWith: CGFloat = 2
    }
    
    override public func layoutSubviews() {
        setHighlightContainerView()
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
            model = genericUI

            backgroundColor = model?.cardBackgroundColor

            setTitle()
            setSubtitle()
            addGradientLayer()
            setDescription()
            setHighlightLabel()
            setHighlightContainerView()
            setPaymentMethodImage()
        }
        
        layer.masksToBounds = true
        setImageContainer()
    }
    
    private func setTitle() {
        guard let genericUI = model else { return }
        titleLabel.text = genericUI.titleName
        titleLabel.font = genericUI.titleWeight.getFont(size: Sizes.titleFont)
        titleLabel.textColor = UIColor.fromHex(genericUI.titleTextColor)
    }
    
    private func setSubtitle() {
        guard let genericUI = model else { return }
        subtitleLabel.text = genericUI.subtitleName
        subtitleLabel.font = genericUI.subtitleWeight.getFont(size: Sizes.subtitleFont)
        subtitleLabel.textColor = UIColor.fromHex(genericUI.subtitleTextColor)
    }
    
    private func addGradientLayer() {
        guard let gradientColors = model?.gradientColors?.map({ UIColor.fromHex($0).cgColor }) else { return }
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        
        gradientView.layer.insertSublayer(gradient, at: 0)
        gradient.colors = gradientColors
        gradient.startPoint =  CGPoint(x: 0.1, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0)
    }
    
    private func setHighlightContainerView() {
        guard let color = model?.labelBackgroundColor else { return }
        highlightContainerView.layer.masksToBounds = true
        highlightContainerView.backgroundColor = UIColor.fromHex(color)
        let path = UIBezierPath(roundedRect: highlightContainerView.bounds,
                                byRoundingCorners: [.bottomLeft],
                                cornerRadii: CGSize(width: highlightContainerView.frame.height/2,
                                                    height: highlightContainerView.frame.height/2))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        highlightContainerView.layer.mask = mask
    }
    
    private func setDescription() {
        guard let name = model?.descriptionName, let weight = model?.descriptionWeight, let descriptionTextColor = model?.descriptionTextColor else {
            return
        }
        
        descriptionLabel.isHidden = false
        descriptionLabel.text = name
        descriptionLabel.font = weight.getFont(size: Sizes.descriptionFont)
        descriptionLabel.textColor = UIColor.fromHex(descriptionTextColor)
    }
    
    private func setHighlightLabel() {
        guard let genericUI = model else { return }
        highlightLabel.isHidden = genericUI.labelName.isEmpty
        highlightLabel.text = genericUI.labelName
        highlightLabel.font = genericUI.labelWeight.getFont(size: Sizes.tagFont)
        highlightLabel.textColor = UIColor.fromHex(genericUI.labelTextColor)
    }
    
    private func setImageContainer() {
        imageContainerView.layer.borderWidth = Sizes.imageContainerBorderWith
        imageContainerView.backgroundColor = .white
        imageContainerView.layer.borderColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1).cgColor
    }
    
    private func setPaymentMethodImage() {
        guard let genericUI = model else { return }
        imageView.image = nil
        UIImageView().getRemoteImage(imageUrl: genericUI.logoImageURL) { image in
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
