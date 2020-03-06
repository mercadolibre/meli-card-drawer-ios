import UIKit

class FrontView: CardView {
    @IBOutlet weak var expirationDate: CardLabel!
    @IBOutlet weak var name: CardLabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var bank: UIImageView!
    @IBOutlet weak var remotePaymentMethodImage: UIImageView!
    @IBOutlet weak var remoteBankImage: UIImageView!
    @IBOutlet weak var number: CardLabel!
    @IBOutlet weak var securityCodeCircle: CircleView!

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        
        setupSecurityCode(cardUI)
        setupCardLogo(in: logo)
        setupRemoteOrLocalImages(cardUI)
        
        setupFormatters(cardUI)
        setupCardElements(cardUI)
        
        cardBackground = cardUI.cardBackgroundColor
        setupCustomOverlayImage(cardUI)
    }
    
    private func setupFormatters(_ cardUI: CardUI) {
        securityCode.formatter = Mask(pattern: [cardUI.securityCodePattern])
        name.formatter = Mask(placeholder: cardUI.placeholderName)
        number.formatter = Mask(pattern: cardUI.cardPattern, digits: model?.lastDigits)
        expirationDate.formatter = Mask(placeholder: cardUI.placeholderExpiration)
    }
    
    private func setupCardElements(_ cardUI: CardUI) {
        let input = [model?.name, model?.expiration, model?.securityCode]
        [name, expirationDate, securityCode].enumerated().forEach({
            $0.element?.setup(input[$0.offset], FontFactory.font(cardUI))
        })

        number.setup(model?.number, FontFactory.font(cardUI, shadow: true))
    }
    
    private func setupSecurityCode(_ cardUI: CardUI) {
        securityCodeCircle.alpha = 0
        securityCode.textColor = cardUI.cardFontColor
        securityCode.isHidden = cardUI.securityCodeLocation == .back
    }

    override func addObservers() {
        addObserver(name, forKeyPath: #keyPath(model.name), options: .new, context: nil)
        addObserver(number, forKeyPath: #keyPath(model.number), options: .new, context: nil)
        addObserver(expirationDate, forKeyPath: #keyPath(model.expiration), options: .new, context: nil)
        addObserver(securityCode, forKeyPath: #keyPath(model.securityCode), options: .new, context: nil)
    }

    deinit {
        removeObserver(name, forKeyPath: #keyPath(model.name))
        removeObserver(number, forKeyPath: #keyPath(model.number))
        removeObserver(expirationDate, forKeyPath: #keyPath(model.expiration))
        removeObserver(securityCode, forKeyPath: #keyPath(model.securityCode))
    }
}

// MARK: Publics
extension FrontView {
    override func setupAnimated(_ cardUI: CardUI) {
        if !(cardUI is CustomCardDrawerUI) {
            Animator.overlay(on: self,
                             cardUI: cardUI,
                             views: [bank, expirationDate, logo, name, number, securityCode],
                             complete: {[weak self] in
                                self?.setupUI(cardUI)
            })
        }
    }

    override func showSecurityCode() {
        securityCodeCircle.alpha = 1
    }

    private func setupRemoteOrLocalImages(_ cardUI: CardUI) {
        setBankImage(cardUI)
        setPaymentMethodImage(cardUI)
    }

    private func setPaymentMethodImage(_ cardUI: CardUI) {
        logo.image = nil
        remotePaymentMethodImage.image = nil
        if let logoImage = cardUI.cardLogoImageUrl, let logoImageUrl = logoImage {
            UIImageView().getRemoteImage(imageUrl: logoImageUrl) { remoteLogoImage in
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.setImage(remoteLogoImage, inImageView: weakSelf.remotePaymentMethodImage, scaleHeight: true)
                }
            }
        } else if let lImage = cardUI.cardLogoImage, let image = lImage {
            setImage(image, inImageView: logo)
        }
    }

    private func setBankImage(_ cardUI: CardUI) {
        bank.image = nil
        remoteBankImage.image = nil
        if let bankImage = cardUI.bankImageUrl, let bankImageUrl = bankImage {
            UIImageView().getRemoteImage(imageUrl: bankImageUrl) { remoteBankImage in
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.setImage(remoteBankImage, inImageView: weakSelf.remoteBankImage, scaleHeight: true)
                }
            }
        } else if let bImage = cardUI.bankImage, let image = bImage {
            setImage(image, inImageView: bank)
        }
    }

    private func setImage(_ tImage: UIImage, inImageView: UIImageView, scaleHeight: Bool = false) {
        if disabledMode {
            inImageView.image = tImage.imageGreyScale()
        } else {
            inImageView.image = scaleHeight ? UIImage.scale(image: tImage, by: inImageView.bounds.size.height/tImage.size.height) : tImage
        }
    }
}
