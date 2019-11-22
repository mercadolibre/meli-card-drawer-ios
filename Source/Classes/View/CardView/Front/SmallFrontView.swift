import UIKit

class SmallFrontView: CardView {

    @IBOutlet weak var number: CardLabel!

    @IBOutlet weak var debitImage: UIImageView!
    @IBOutlet weak var remoteBankImage: UIImageView!
    @IBOutlet weak var remotePaymentMethodImage: UIImageView!
    
    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .small)
        
        setupRemoteOrLocalImages(cardUI)
        
        setupCardLabels(cardUI)
        
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
        if !(cardUI is CustomCardDrawerUI) {
            Animator.overlay(on: self,
                             cardUI: cardUI,
                             views: [remotePaymentMethodImage, debitImage, number, remoteBankImage],
                             complete: {[weak self] in
                                self?.setupUI(cardUI)
            })
        }
    }
    
    private func setupRemoteOrLocalImages(_ cardUI: CardUI) {
        setPaymentMethodImage(cardUI)
        setDebitImage(cardUI)
    }
    
    private func setPaymentMethodImage(_ cardUI: CardUI) {
        remotePaymentMethodImage.image = nil
        if let logoImage = cardUI.cardLogoImageUrl, let logoImageUrl = logoImage {
            UIImageView().getRemoteImage(imageUrl: logoImageUrl) { remoteLogoImage in
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.setImage(remoteLogoImage, inImageView: weakSelf.remotePaymentMethodImage, scaleHeight: true)
                }
            }
        } else if let lImage = cardUI.cardLogoImage {
            setImage(lImage, inImageView: remotePaymentMethodImage)
        }
    }
    
    private func setDebitImage(_ cardUI: CardUI) {
        debitImage.image = nil
        if let debitImage = cardUI.debitImageUrl, let debitImageUrl = debitImage {
            UIImageView().getRemoteImage(imageUrl: debitImageUrl) { debitImage in
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.setImage(debitImage, inImageView: weakSelf.debitImage)
                }
            }
        }
    }
    
    private func setImage(_ tImage: UIImage?, inImageView: UIImageView, scaleHeight: Bool = false) {
        if disabledMode {
            inImageView.image = tImage?.imageGreyScale()
        } else {
            inImageView.image = scaleHeight ? UIImage.scale(image: tImage!, by: inImageView.bounds.size.height/tImage!.size.height) : tImage
        }
    }
    
    private func setupCardLabels(_ cardUI: CardUI) {
        number.setup(model?.number, FontFactory.font(cardUI))
        number.font = number.font.withSize(12)
    }
}
