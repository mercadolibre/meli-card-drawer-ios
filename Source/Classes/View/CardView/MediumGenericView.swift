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
    @IBOutlet weak var highlightContainerView: UIView!
    @IBOutlet weak var highlightTagBottomView: UIView!
    @IBOutlet weak var highlightTagBottonLabel: UILabel!
    
    private var model: GenericCardUI?
    private var isDisabled: Bool = false
    private var isTagBottomEnabled: Bool = false
    
    private struct FontSizes {
        static let title: CGFloat = 14
        static let subtitle: CGFloat = 14
        static let description: CGFloat = 12
        static let badge: CGFloat = 11
    }

    private struct Colors {
        static let disabledHighlightLabel = UIColor.fromHex("#A0A0A0")
        static let disabledHighlightContainerView = UIColor.fromHex("#F0F0F0")
        static let disabledGradientColorsStart = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        static let disabledGradientColorsEnd = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        static let disabledImageColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
    }
    
    override public func layoutSubviews() {
        setHighlightContainerView()
    }
    
    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool = false, customLabelFontName: String?) {
        self.frame = frame
        self.isDisabled = isDisabled
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
            model = genericUI

            if let gradient = model?.gradientColors, gradient.isEmpty {
                backgroundColor = isDisabled ? Colors.disabledGradientColorsStart : model?.cardBackgroundColor
            }

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
        titleLabel.font = genericUI.titleWeight.getFont(size: FontSizes.title)
        titleLabel.textColor = isDisabled ? UIColor.white : UIColor.fromHex(genericUI.titleTextColor)
    }
    
    private func setSubtitle() {
        guard let genericUI = model else { return }
        subtitleLabel.text = genericUI.subtitleName
        subtitleLabel.font = genericUI.subtitleWeight.getFont(size: FontSizes.subtitle)
        subtitleLabel.textColor = UIColor.fromHex(genericUI.subtitleTextColor)
        subtitleLabel.textColor = isDisabled ? UIColor.white : UIColor.fromHex(genericUI.subtitleTextColor)
    }
    
    private func addGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        
        gradientView.layer.insertSublayer(gradient, at: 0)
        let gradientColors = model?.gradientColors?.map({ UIColor.fromHex($0).cgColor })

        gradient.colors = isDisabled ? [Colors.disabledGradientColorsStart.cgColor, Colors.disabledGradientColorsEnd.cgColor] : gradientColors
        gradient.startPoint =  CGPoint(x: 0.1, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0)
    }
    
    private func setHighlightContainerView() {
        guard let genericUI = model else { return }
        highlightContainerView.isHidden = genericUI.labelName.isEmpty
        
        if !genericUI.labelBackgroundColor.isEmpty {
            highlightContainerView.backgroundColor = isDisabled ? UIColor.white : UIColor.fromHex(genericUI.labelBackgroundColor)
        }
        
        highlightContainerView.layer.masksToBounds = true
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
        descriptionLabel.font = weight.getFont(size: FontSizes.description)
        descriptionLabel.textColor = isDisabled ? UIColor.white : UIColor.fromHex(descriptionTextColor)
    }
    
    private func setHighlightLabel() {
        guard let genericUI = model else { return }
        highlightLabel.isHidden = genericUI.labelName.isEmpty
        highlightLabel.text = genericUI.labelName
        highlightLabel.font = genericUI.labelWeight.getFont(size: FontSizes.badge)
        highlightLabel.textColor = isDisabled ? Colors.disabledHighlightLabel : UIColor.fromHex(genericUI.labelTextColor)
        highlightContainerView.layoutIfNeeded()
    }
    
    private func setImageContainer() {
        imageContainerView.layer.borderWidth = 2
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
    
    func addCardBalance(_ model: CardBalanceModel, _ showBalance: Bool, _ delegate: CardBalanceDelegate) {}

    
    func addTagBottom(containerView: UIView, isDisabled: Bool, cardType: MLCardDrawerTypeV3, tagBottom: Text?, toggleTagBottom: Bool = false){
        if toggleTagBottom {
            if cardType.rawValue >= MLCardDrawerTypeV3.small.rawValue {
                if let tagBottom = tagBottom{
                    var isHighlightTagBottonLabel = CardView.createTagBottom(tagBottom, disablemode: isDisabled)
                    guard let isHighlightTagBottomView = highlightTagBottomView else { return }
                    isHighlightTagBottomView.isHidden = false
                    highlightTagBottonLabel.isHidden = false
                    isHighlightTagBottomView.backgroundColor = isHighlightTagBottonLabel.backgroundColor
                    highlightTagBottonLabel.text = isHighlightTagBottonLabel.text
                    highlightTagBottonLabel.textColor = isHighlightTagBottonLabel.textColor
                    isHighlightTagBottomView.preencherTagBottom(top: nil,
                                                          leading: nil,
                                                          trailing: trailingAnchor,
                                                          bottom: bottomAnchor,
                                                          padding:.init(top: 0, left: 0, bottom: 20, right: 0),
                                                              size: CGSize(width: highlightTagBottonLabel.intrinsicContentSize.width + ConstantsValues.SPACING, height: ConstantsValues.HEIGHT))
                    
                    highlightTagBottonLabel.preencherTagBottom(top: nil,
                                                          leading: nil,
                                                          trailing: trailingAnchor,
                                                          bottom: bottomAnchor,
                                                          padding:.init(top: 0, left: 0, bottom: 20, right: 10),
                                                               size: CGSize(width: highlightTagBottonLabel.intrinsicContentSize.width, height: ConstantsValues.HEIGHT))
                    isHighlightTagBottomView.roundCorners(cornerRadiuns: 12, typeCorners: [.topLeft,.lowerLeft])
                }
            }
        } else {
            highlightTagBottomView.isHidden = true
            highlightTagBottonLabel.isHidden = true
        }
    }
}
