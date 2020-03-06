import UIKit

class SmallFrontView: CardView {

    @IBOutlet weak var number: CardLabel!

    @IBOutlet weak var debitImage: UIImageView!
    @IBOutlet weak var paymentMethodImage: UIImageView!
    
    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .small)
        
        setPaymentMethodImage(cardUI)
        setDebitImage(cardUI)
        setupCardLabels(cardUI)
        setupFormatters(cardUI)
        
        cardBackground = cardUI.cardBackgroundColor
        setupCustomOverlayImage(cardUI)
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
        Animator.overlay(on: self,
                         cardUI: cardUI,
                         views: [paymentMethodImage, debitImage, number],
                         complete: {[weak self] in
                            self?.setupUI(cardUI)
        })
    }
    
    private func setupRemoteOrLocalImages(_ cardUI: CardUI) {
        setPaymentMethodImage(cardUI)
        setDebitImage(cardUI)
    }
    
    private func setupFormatters(_ cardUI: CardUI) {
        number.formatter = Mask(pattern: cardUI.cardPattern, digits: model?.lastDigits)
    }
    
    private func setPaymentMethodImage(_ cardUI: CardUI) {
        paymentMethodImage.image = nil
        if let image = cardUI.cardLogoImage,
            let pImage = image {
            setImage(pImage, inImageView: paymentMethodImage, scaleHeight: true)
        }
    }
    
    private func setDebitImage(_ cardUI: CardUI) {
        debitImage.image = nil
        if let image = cardUI.debitImage,
            let dImage = image {
            setImage(dImage, inImageView: debitImage)
        }
    }
    
    private func setImage(_ tImage: UIImage, inImageView: UIImageView, scaleHeight: Bool = false) {
        if disabledMode {
            inImageView.image = tImage.imageGreyScale()
        } else {
            inImageView.image = scaleHeight ? UIImage.scale(image: tImage, by: inImageView.bounds.size.height/tImage.size.height) : tImage
        }
    }
    
    private func setupCardLabels(_ cardUI: CardUI) {
        number.setup(model?.number, FontFactory.font(cardUI, shadow: true))
        number.font = number.font.withSize(12)
    }
}
