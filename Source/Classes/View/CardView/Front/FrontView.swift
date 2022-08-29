import UIKit

class FrontView: CardView {
    @IBOutlet weak var paymentMethodImage: UIImageView!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var fullArt: UIImageView!
    @IBOutlet weak var securityCodeCircle: CircleView!
    @IBOutlet weak var safeZone: UIView!
    @IBOutlet weak var cardBalanceContainer: CardBalance!
    @IBOutlet weak var PANView: PANView!
    
    // Constraints
    @IBOutlet var paymentMethodImageCenterAnchor: NSLayoutConstraint!
    var paymentMethodImageBottomAnchorSafezone: NSLayoutConstraint?
    
    @IBOutlet var paymentMethodImageHeightSize: NSLayoutConstraint!
    var paymentMethodImageHeightSizeSafezone: NSLayoutConstraint?
    
    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        setupSecurityCode(cardUI)
        setupFormatters(cardUI)
        setupCardElements(cardUI)
        setupCardDesign(cardUI)
    }
    
    private func setupCardDesign(_ cardUI: CardUI) {
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        
        if cardUI.fullCardArt == nil {
            setupDefaultDesign(cardUI)
        } else {
            setupFullCardArt(cardUI)
        }
    }

    private func setupDefaultDesign(_ cardUI: CardUI) {
        setupPAN(cardUI)
        setupCardImages(cardUI)
        cardBackground = cardUI.cardBackgroundColor
        setupCustomOverlayImage(cardUI)
    }
    
    private func setupFullCardArt(_ cardUI: CardUI) {
        bankImage.image = nil
        paymentMethodImage.image = nil
        setCardFullArtImage(cardUI)
    }
    
    private func setupCardImages(_ cardUI: CardUI) {
        fullArt.image = nil

        if cardUI.set(logo:) != nil {
            setupCardLogo(in: paymentMethodImage)
        }
        
        if cardUI.set(bank:) != nil {
            setupBankImage(in: bankImage)
        }
        
        setupRemoteOrLocalImages(cardUI)
    }
    
    private func setupFormatters(_ cardUI: CardUI) {
        securityCode.formatter = Mask(pattern: [cardUI.securityCodePattern])
    }
    
    private func setupCardElements(_ cardUI: CardUI) {
        let input = [model?.securityCode]
        [securityCode].enumerated().forEach({
            $0.element?.setup(input[$0.offset], FontFactory.font(cardUI), customLabelFontName: customLabelFontName)
        })
    }
    
    private func setupSecurityCode(_ cardUI: CardUI) {
        securityCodeCircle.alpha = 0
        securityCode.textColor = cardUI.cardFontColor
        securityCode.isHidden = cardUI.securityCodeLocation == .back
    }
    
    private func setupPAN(_ cardUI: CardUI) {
        if self.PANView.getLabel() == nil,
           let number = model?.number,
           number.count > 0 { // TODO: this will be improved when integrating CardForm
            PANView.render()
            PANView.setNumber(String("•••• " + number.suffix(4)))
            PANView.setPANStyle(cardUI)
        }
    }

    override func addObservers() {
        addObserver(securityCode, forKeyPath: #keyPath(model.securityCode), options: .new, context: nil)
    }

    deinit {
        removeObserver(securityCode, forKeyPath: #keyPath(model.securityCode))
    }
    
    func setSafeZoneConstraints () {
        securityCode.isHidden = true
        
        paymentMethodImageCenterAnchor.isActive = false
        paymentMethodImageHeightSize.isActive = false
        
        paymentMethodImageBottomAnchorSafezone = paymentMethodImage.bottomAnchor.constraint(equalTo: safeZone.topAnchor, constant: 0)
        paymentMethodImageHeightSizeSafezone = paymentMethodImage.heightAnchor.constraint(equalToConstant: 43.0)
        
        paymentMethodImageBottomAnchorSafezone?.isActive = true
        paymentMethodImageHeightSizeSafezone?.isActive = true
        
        // Make SafeZone visible and add customView
        if let customView = self.customView {
            safeZone.addSubview(customView)
            customView.pinEdges(to: safeZone)
            safeZone.isHidden = false
        }
    }
    
    func clearSafeZoneConstraints() {
        securityCode.isHidden = false
        
        paymentMethodImageBottomAnchorSafezone?.isActive = false
        paymentMethodImageHeightSizeSafezone?.isActive = false

        paymentMethodImageCenterAnchor.isActive = true
        paymentMethodImageHeightSize.isActive = true
        
        // Make SafeZone hidden and remove customView
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
extension FrontView {
    override func setupAnimated(_ cardUI: CardUI) {
        if !(cardUI is CustomCardDrawerUI) {
            Animator.overlay(on: self,
                             cardUI: cardUI,
                             views: [bankImage, paymentMethodImage, securityCode],
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
    
    private func setCardFullArtImage(_ cardUI: CardUI) {
        fullArt.image = nil
        if let imageUrl = cardUI.fullCardArt as? String, !imageUrl.isEmpty {
            UIImageView().getRemoteImage(imageUrl: imageUrl) { image in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.setImage(image, inImageView: self.fullArt)
                }
            }
        }
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

// MARK: SafeArea feature
extension FrontView {
    
    override func addCustomView(_ customView: UIView) {
        self.customView = customView
        setSafeZoneConstraints()
    }
    
    override func removeCustomView() {
        clearSafeZoneConstraints()
    }
}
