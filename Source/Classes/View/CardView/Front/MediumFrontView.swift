import UIKit

class MediumFrontView: CardView {
    @IBOutlet weak var paymentMethodImage: UIImageView!
    @IBOutlet weak var issuerImage: UIImageView!
    @IBOutlet weak var chevronIcon: UIImageView!
    @IBOutlet weak var cardBalanceContainer: CardBalance!
    @IBOutlet weak var PANView: PANView!
    
    private var shineView: ShineView?
    
    // Constraints
    var paymentMethodTrailingChevron: NSLayoutConstraint?
    @IBOutlet var paymentMethodTrailing: NSLayoutConstraint!
    
    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .medium)
        
        setupPAN(cardUI)
        setIssuerImage(cardUI)
        setPaymentMethodImage(cardUI)
        setupChevron(cardUI)
        
        cardBackground = cardUI.cardBackgroundColor
        setupCustomOverlayImage(cardUI)
    }
    
    override func addObservers() {}
    
    override func addCardBalance(_ model: CardBalanceModel, _ showBalance: Bool, _ delegate: CardBalanceDelegate) {
        cardBalanceContainer.model = model
        cardBalanceContainer.showBalance = showBalance
        cardBalanceContainer.delegate = delegate
        cardBalanceContainer.render()
    }
}

extension MediumFrontView {
    override func setupAnimated(_ cardUI: CardUI) {
        Animator.overlay(on: self,
                         cardUI: cardUI,
                         views: [issuerImage, paymentMethodImage, chevronIcon],
                         complete: {[weak self] in
            self?.setupUI(cardUI)
        })
    }
    
    private func setupPAN(_ cardUI: CardUI) {
        PANView.cardUI = cardUI
        let number = model?.number ?? ""
        let numberLength = cardUI.cardPattern.reduce(0, +)
        
        if !PANView.isRendered() { PANView.render() }
        if number.count == 0 { PANView.isHidden = true }
        if number.count == numberLength {
            PANView.setNumber(String(number.suffix(4)), withPad: true)
        }
        PANView.setPANStyle(cardUI, disabledMode)
    }
    
    private func setPaymentMethodImage(_ cardUI: CardUI) {
        paymentMethodImage.image = nil
        if let imageUrl = cardUI.cardLogoImageUrl as? String, !imageUrl.isEmpty  {
            UIImageView().getRemoteImage(imageUrl: imageUrl) { image in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.setImage(image, inImageView: self.paymentMethodImage, scaleHeight: true)
                }
            }
        } else if let image = cardUI.cardLogoImage as? UIImage {
            setImage(image, inImageView: paymentMethodImage, scaleHeight: true)
        }
    }
    
    private func setIssuerImage(_ cardUI: CardUI) {
        issuerImage.image = nil
        if let imageUrl = cardUI.bankImageUrl as? String, !imageUrl.isEmpty  {
            UIImageView().getRemoteImage(imageUrl: imageUrl) { image in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.setImage(image, inImageView: self.issuerImage, scaleHeight: true)
                }
            }
        } else if let image = cardUI.bankImage as? UIImage {
            setImage(image, inImageView: issuerImage, scaleHeight: true)
        }
    }
    
    private func setupChevron(_ cardUI: CardUI) {
        showChevron(cardUI.showChevron == true)
        chevronIcon.image = chevronIcon.image?.withRenderingMode(.alwaysTemplate)
        chevronIcon.tintColor = getChevronColor(cardUI)
    }
    
    private func setImage(_ tImage: UIImage, inImageView: UIImageView, scaleHeight: Bool = false) {
        if disabledMode {
            inImageView.image = tImage.imageGreyScale()
        } else {
            let aspectRatio = tImage.size.height/tImage.size.width
            inImageView.image = scaleHeight ? UIImage.scale(image: tImage, by: (inImageView.bounds.size.height+max(-4,min(24*aspectRatio-15,0)))/tImage.size.height) : tImage
        }
    }
}

//MARK: Chevron config
private extension MediumFrontView {
    private func getChevronColor(_ cardUI: CardUI) -> UIColor {
        switch cardUI.fontType {
        case "light":
            return #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        case "dark":
            return #colorLiteral(red: 0.4509803922, green: 0.4509803922, blue: 0.4509803922, alpha: 1)
        default:
            return cardUI.cardFontColor
        }
    }
    
    func showChevron(_ value: Bool) {
        chevronIcon.isHidden = !value
//        if !value {
//            paymentMethodTrailing = paymentMethodImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
//            paymentMethodTrailing?.isActive = true
//        }
        if value {
            paymentMethodTrailing.isActive = false
            paymentMethodTrailingChevron = paymentMethodImage.trailingAnchor.constraint(equalTo: chevronIcon.leadingAnchor, constant: -4)
            paymentMethodTrailingChevron?.isActive = true
        }
    }
}
