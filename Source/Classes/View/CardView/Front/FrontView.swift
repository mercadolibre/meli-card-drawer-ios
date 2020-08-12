import UIKit

class FrontView: CardView {
    @IBOutlet weak var expirationDate: CardLabel!
    @IBOutlet weak var name: CardLabel!
    @IBOutlet weak var paymentMethodImage: UIImageView!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var number: CardLabel!
    @IBOutlet weak var securityCodeCircle: CircleView!

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        
        setupSecurityCode(cardUI)
        if cardUI.set(logo:) != nil {
            setupCardLogo(in: paymentMethodImage)
        }
        if cardUI.set(bank:) != nil {
            setupBankImage(in: bankImage)
        }
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
            $0.element?.setup(input[$0.offset], FontFactory.font(cardUI), customLabelFontName: customLabelFontName)
        })

        number.setup(model?.number, FontFactory.font(cardUI, shadow: true), customLabelFontName: customLabelFontName)
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
                             views: [bankImage, expirationDate, paymentMethodImage, name, number, securityCode],
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
        paymentMethodImage.image = nil
        if let imageUrl = cardUI.cardLogoImageUrl as? String, !imageUrl.isEmpty {
            UIImageView().getRemoteImage(imageUrl: imageUrl) { image in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.setImage(image, inImageView: self.paymentMethodImage)
                }
            }
        } else if let image = cardUI.cardLogoImage as? UIImage {
            setImage(image, inImageView: paymentMethodImage)
        }
    }

    private func setBankImage(_ cardUI: CardUI) {
        bankImage.image = nil
        if let imageUrl = cardUI.bankImageUrl as? String, !imageUrl.isEmpty {
            UIImageView().getRemoteImage(imageUrl: imageUrl) { remoteBankImage in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.setImage(remoteBankImage, inImageView: self.bankImage)
                }
            }
        } else if let image = cardUI.bankImage as? UIImage {
            setImage(image, inImageView: bankImage)
        }
    }

    private func setImage(_ tImage: UIImage, inImageView: UIImageView) {
        inImageView.image = UIImage.scale(image: tImage,
                                          by: inImageView.bounds.size.height/tImage.size.height)
        if disabledMode {
            inImageView.image = tImage.imageGreyScale()
        }
    }
}
