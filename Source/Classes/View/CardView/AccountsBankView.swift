//
//  AccountsBankView.swift
//  MLCardDrawer
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 25/03/22.
//

import UIKit

class AccountsBankView: UIView, BasicCard {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var termsAndConditionsLabel: UILabel? = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private var model: AccountsBankCardUI?
    private var isDisabled: Bool = false

    private struct Colors {
        static let disabledHighlightLabel = UIColor.fromHex("#A0A0A0")
        static let disabledHighlightContainerView = UIColor.fromHex("#F0F0F0")
        static let disabledGradientColorsStart = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        static let disabledGradientColorsEnd = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        static let disabledImageColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
    }
    
    private struct Sizes {
        static let titleFont: CGFloat = 14
        static let subtitleFont: CGFloat = 14
        static let descriptionFont: CGFloat = 12
        static let tagFont: CGFloat = 12
        static let imageContainerBorderWith: CGFloat = 2
    }
    
    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool, customLabelFontName: String?) {
        guard let model = cardUI as? AccountsBankCardUI else { return }
        self.model = model
        self.frame = frame
        self.isDisabled = isDisabled

        loadFromNib()
        setupUI(cardUI)
    }
    
    func setupUI(_ cardUI: CardUI) {
        layer.masksToBounds = true
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)

        backgroundColor = isDisabled ? Colors.disabledGradientColorsStart : model?.cardBackgroundColor
        
        addGradientLayer()
        setTitle()
        setImage()
        setTermsAndConditions()
    }
    
    private func addGradientLayer() {
        guard let model = model else { return }

        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        gradientView.layer.insertSublayer(gradient, at: 0)
        
        let gradientColors = model.gradientColors.map({ UIColor.fromHex($0).cgColor })
        gradient.colors = isDisabled ? [Colors.disabledGradientColorsStart.cgColor, Colors.disabledGradientColorsEnd.cgColor] : gradientColors
        gradient.startPoint =  CGPoint(x: 0.1, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0)
    }
    
    private func setTitle() {
        guard let model = model else { return }
        accountBalanceLabel.text = model.titleName
        accountBalanceLabel.textColor = isDisabled ? .white : .fromHex(model.titleTextColor)
        accountBalanceLabel.font = model.titleWeight.getFont(size: Sizes.descriptionFont)

        bankLabel.text = model.subtitleName
        bankLabel.textColor = isDisabled ? .white : .fromHex(model.titleTextColor)
        bankLabel.font = model.subtitleWeight.getFont(size: Sizes.subtitleFont)

    }
    
    private func setImage() {
        guard let model = model else { return }
        imageView.image = nil

        UIImageView().getRemoteImage(imageUrl: model.logoImageURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = image
                self.imageView.contentMode = .scaleAspectFit
                self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
                self.imageView.clipsToBounds = true
            }
        }
        
        if isDisabled {
            turnGrayLogo()
        }
    }
    
    private func turnGrayLogo() {
        let grayLayer = CALayer()
        grayLayer.frame = bounds
        grayLayer.compositingFilter = "colorBlendMode"
        grayLayer.backgroundColor = Colors.disabledImageColor.cgColor
        imageView.alpha = 0.5
        imageView.layer.addSublayer(grayLayer)
    }
    
    private func setTermsAndConditions() {
        guard let model = model, let textColor = model.termsTextColor else { return }
        termsAndConditionsLabel?.text = model.termsMessage
        termsAndConditionsLabel?.textColor = isDisabled ? .white : .fromHex(textColor)
        termsAndConditionsLabel?.font = model.subtitleWeight.getFont(size: Sizes.subtitleFont)
    }
    
    func isShineEnabled() -> Bool { return false }
    
    func addShineView() { }
    
    func removeShineView() { }
    
    func removeGradient() { }
    
    func addGradient() { }
    
    func setupAnimated(_ cardUI: CardUI) { }
}
