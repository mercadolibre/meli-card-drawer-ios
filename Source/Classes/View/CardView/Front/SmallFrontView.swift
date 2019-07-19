import UIKit

class SmallFrontView: CardView {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var number: CardLabel!

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)

        if let cardLogoImage = cardUI.cardLogoImage{
            logo.image = setupImage(image: cardLogoImage, disabledMode: disabledMode)
        }

        cardUI.set?(logo: logo)
        
        number.formatter = Mask(pattern: cardUI.cardPattern, digits: model?.lastDigits)
        number.setup(model?.number, FontFactory.font(cardUI))

        cardBackground = cardUI.cardBackgroundColor
        setupCustomOverlayImage(cardUI)

        if isShineEnabled() {
            addShineView()
        }
    }

    override func addObservers() {
        addObserver(number, forKeyPath: #keyPath(model.number), options: .new, context: nil)
    }

    deinit {
        removeObserver(number, forKeyPath: #keyPath(model.number))
    }
}

// MARK: Publics
extension SmallFrontView {
    override func setupAnimated(_ cardUI: CardUI) {
        if !(cardUI is CustomCardDrawerUI) {
            Animator.overlay(on: self,
                             cardUI: cardUI,
                             views: [logo, number],
                             complete: {[weak self] in
                                self?.setupUI(cardUI)
            })
        }
    }
}
