import UIKit

class MediumFrontView: CardView {
    @IBOutlet weak var paymentMethodImage: UIImageView!
    @IBOutlet weak var issuerImage: UIImageView!
    @IBOutlet weak var number: CardLabel!
    @IBOutlet weak var debitImage: UIImageView!
    @IBOutlet weak var nameLabel: CardLabel!
    @IBOutlet weak var chevronIcon: UIImageView!
    
    @IBOutlet weak var numberTrailingConstraint: NSLayoutConstraint!
    
    private var shineView: ShineView?

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .medium)
        
        setIssuerImage(cardUI)
        setPaymentMethodImage(cardUI)
        setDebitImage(cardUI)
        setupCardLabels(cardUI)
        setupChevron(cardUI)
        setupFormatters(cardUI)
        
        cardBackground = cardUI.cardBackgroundColor
        setupCustomOverlayImage(cardUI)
        
    }
    
    override func addObservers() {
        addObserver(nameLabel, forKeyPath: #keyPath(model.name), options: .new, context: nil)
        addObserver(number, forKeyPath: #keyPath(model.number), options: .new, context: nil)
    }

    deinit {
        removeObserver(number, forKeyPath: #keyPath(model.number))
        removeObserver(nameLabel, forKeyPath: #keyPath(model.name))
    }
}

// MARK: Publics
extension MediumFrontView {
    override func setupAnimated(_ cardUI: CardUI) {
        Animator.overlay(on: self,
                         cardUI: cardUI,
                         views: [issuerImage, paymentMethodImage, debitImage, nameLabel, number, chevronIcon],
                         complete: {[weak self] in
                            self?.setupUI(cardUI)
        })
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
    
    private func setIssuerImage(_ cardUI: CardUI) {
        issuerImage.image = nil
        if let image = cardUI.bankImage,
            let bImage = image  {
            setImage(bImage, inImageView: issuerImage, scaleHeight: true)
        }
    }
    
    private func setDebitImage(_ cardUI: CardUI) {
        debitImage.image = nil
        if let image = cardUI.debitImage,
            let dImage = image {
            setImage(dImage, inImageView: debitImage)
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
            inImageView.image = scaleHeight ? UIImage.scale(image: tImage, by: inImageView.bounds.size.height/tImage.size.height) : tImage
        }
    }
    
    private func setupCardLabels(_ cardUI: CardUI) {
        nameLabel.setup(model?.name ?? "", FontFactory.font(cardUI))
        nameLabel.font = nameLabel.font.withSize(12)
        
        number.setup(model?.number ?? "", FontFactory.font(cardUI))
        number.font = number.font.withSize(12)
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
        numberTrailingConstraint.priority = value ? .defaultLow : .required
        chevronIcon.isHidden = !value
    }
    
}
