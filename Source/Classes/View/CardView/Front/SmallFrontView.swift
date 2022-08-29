import UIKit

public class SmallFrontView: CardView {
    @IBOutlet weak var paymentMethodImage: UIImageView!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var safeZone: UIView!
    @IBOutlet weak var cardBalanceContainer: CardBalance!
    @IBOutlet weak var PANView: PANView!
    
    // Constraints
    @IBOutlet var paymentMethodImageCenterAnchor: NSLayoutConstraint!
    var paymentMethodImageBottomAnchorSafezone: NSLayoutConstraint?
    
    @IBOutlet var paymentMethodImageHeightSize: NSLayoutConstraint!
    var paymentMethodImageHeightSizeSafezone: NSLayoutConstraint?
    
    @IBOutlet weak var paymentMethodImageWidthConstraint: NSLayoutConstraint!
    
    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        
        setPAN(cardUI)
        
        if cardUI.set(logo:) != nil {
            setupCardLogo(in: paymentMethodImage)
        }
        if cardUI.set(bank:) != nil {
            setupBankImage(in: bankImage)
        }
        setupRemoteOrLocalImages(cardUI)
        cardBackground = cardUI.cardBackgroundColor
        setupCustomOverlayImage(cardUI)
        
        layoutIfNeeded()
    }

    override func addObservers() {}

    deinit {}
    
    func setSafeZoneConstraints () {
        paymentMethodImageCenterAnchor.isActive = false
        paymentMethodImageHeightSize.isActive = false
        
        paymentMethodImageBottomAnchorSafezone = paymentMethodImage.bottomAnchor.constraint(equalTo: safeZone.topAnchor, constant: 0)
        paymentMethodImageHeightSizeSafezone = paymentMethodImage.heightAnchor.constraint(equalToConstant: 32.0)
        
        paymentMethodImageBottomAnchorSafezone?.isActive = true
        paymentMethodImageHeightSizeSafezone?.isActive = true
        
        if let customView = customView {
            safeZone.addSubview(customView)
            
            customView.pinEdges(to: safeZone)
            
            safeZone.isHidden = false
        }
    }
    
    func clearSafeZoneConstraints() {
        paymentMethodImageBottomAnchorSafezone?.isActive = false
        paymentMethodImageHeightSizeSafezone?.isActive = false
        
        paymentMethodImageCenterAnchor.isActive = true
        paymentMethodImageHeightSize.isActive = true
        
        // Make SafeZone hidden
        safeZone.isHidden = true
        if let customView = customView {
            customView.removeFromSuperview()
            self.customView = nil
        }
    }
    
    override func addCardBalance(_ model: CardBalanceModel, _ showBalance: Bool, _ delegate: CardBalanceDelegate) {
        cardBalanceContainer.model = model
        cardBalanceContainer.showBalance = showBalance
        cardBalanceContainer.delegate = delegate
        cardBalanceContainer.render()
    }
}

// MARK: Publics
extension SmallFrontView {
    override func setupAnimated(_ cardUI: CardUI) {
        if !(cardUI is CustomCardDrawerUI) {
            Animator.overlay(on: self,
                             cardUI: cardUI,
                             views: [bankImage, paymentMethodImage, PANView],
                             complete: {[weak self] in
                                self?.setupUI(cardUI)
            })
        }
    }
    
    private func setPAN(_ cardUI: CardUI) {
        if self.PANView.getLabel() == nil,
           let number = model?.number,
           number.count > 0 { // TODO: this will be improved when integrating CardForm
            self.PANView.render()
            self.PANView.setPANStyle(cardUI)
            self.PANView.setNumber(String(number.suffix(4)))
        }
    }

    public override func showSecurityCode() {}

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
                    self.setImageScalingImageView(image, inImageView: self.paymentMethodImage)
                }
            }
        } else if let image = cardUI.cardLogoImage as? UIImage {
            setImageScalingImageView(image, inImageView: paymentMethodImage)
        }
        
        if let paymentMethodImage = self.paymentMethodImage as? UIImageViewAligned {
            paymentMethodImage.alignRight = true
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
    
    private func setImageScalingImageView(_ tImage: UIImage, inImageView: UIImageView) {
        
        if disabledMode {
            inImageView.image = tImage.imageGreyScale()
        } else {
            inImageView.image = tImage
        }
    }
}

// MARK: SafeArea feature
extension SmallFrontView {
    
    override func addCustomView (_ customView: UIView) {
        self.customView = customView
        setSafeZoneConstraints()
    }
    
    override func removeCustomView () {
        clearSafeZoneConstraints()
    }
}

