import UIKit

class FrontView: CardView {
    @IBOutlet weak var expirationDate: CardLabel!
    @IBOutlet weak var name: CardLabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var bank: UIImageView!
    @IBOutlet weak var number: CardLabel!
    @IBOutlet weak var securityCodeCircle: CircleView!

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        
        securityCode.formatter = Mask(pattern: [cardUI.securityCodePattern])

        securityCodeCircle.alpha = 0
        
        if let bankImage = cardUI.bankImage {
            bank.image = setupImage(image: bankImage, disabledMode: disabledMode)
        }
        
        if let cardLogoImage = cardUI.cardLogoImage{
            logo.image = setupImage(image: cardLogoImage, disabledMode: disabledMode)
        }

        cardUI.set?(logo: logo)
        cardUI.set?(bank: bank)

        securityCode.textColor = cardUI.cardFontColor
        let input = [model?.name, model?.number, model?.expiration, model?.securityCode]
        securityCode.isHidden = cardUI.securityCodeLocation == .back

        name.formatter = Mask(placeholder: cardUI.placeholderName)
        number.formatter = Mask(pattern: cardUI.cardPattern, digits: model?.lastDigits)
        expirationDate.formatter = Mask(placeholder: cardUI.placeholderExpiration)

        [name, number, expirationDate, securityCode].enumerated().forEach({
            $0.element?.setup(input[$0.offset], FontFactory.font(cardUI))
        })

        cardBackground = cardUI.cardBackgroundColor
        setupCustomOverlayImage(cardUI)

        if isShineEnabled() {
            addShineView()
        }
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
}
