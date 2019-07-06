import UIKit

class FrontView: CardView {
    @IBOutlet weak var expirationDate: CardLabel!
    @IBOutlet weak var name: CardLabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var bank: UIImageView!
    @IBOutlet weak var number: CardLabel!
    @IBOutlet weak var securityCodeCircle: CircleView!
    @IBOutlet weak var overlayImage: UIImageView!

    private var cardBackground: UIColor = .clear
    private var shineView: ShineView?

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)

        securityCodeCircle.alpha = 0

        if disabledMode {
            bank.image = cardUI.bankImage??.imageGreyScale()
            logo.image = cardUI.cardLogoImage??.imageGreyScale()
        } else if let bImage = cardUI.bankImage, let lImage = cardUI.cardLogoImage {
            bank.image = bImage
            logo.image = lImage
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
    func setupAnimated(_ cardUI: CardUI) {
        if !(cardUI is CustomCardDrawerUI) {
            Animator.overlay(on: self,
                             cardUI: cardUI,
                             views: [bank, expirationDate, logo, name, number, securityCode],
                             complete: {[weak self] in
                                self?.setupUI(cardUI)
            })
        }
    }

    func showSecurityCode() {
        securityCodeCircle.alpha = 1
    }

    func addShineView() {
        if let shinedView = shineView {
            shinedView.color = cardBackground
        } else {
            shineView = ShineView()
            if let shinedView = shineView {
                shinedView.clipsToBounds = true
                shinedView.color = cardBackground
                shinedView.frame = CGRect(x: self.gradient.frame.origin.x, y: self.gradient.frame.origin.y, width: self.gradient.frame.width * 2, height: self.gradient.frame.height * 6)
                shinedView.center = self.gradient.center
                self.gradient.addSubview(shinedView)
                shinedView.addMotionEffect()
            }
        }
    }

    func removeShineView() {
        shineView?.removeMotionEffects()
        shineView?.removeFromSuperview()
        shineView = nil
    }

    func isShineEnabled() -> Bool {
        return shineView != nil
    }
}

// MARK: Privates
extension FrontView {
    private func setupCustomOverlayImage(_ cardUI: CardUI) {
        if let customOverlayImage = cardUI.ownOverlayImage {
            overlayImage.image = customOverlayImage
        }
    }
}
