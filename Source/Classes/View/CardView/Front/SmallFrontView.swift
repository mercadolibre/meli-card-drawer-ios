//
//  SmallFrontView.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 30/06/2021.
//

import UIKit

public class SmallFrontView: CardView {
    @IBOutlet weak var expirationDate: CardLabel!
    @IBOutlet weak var name: CardLabel!
    @IBOutlet weak var paymentMethodImage: UIImageView!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var number: CardLabel!
    @IBOutlet weak var securityCodeCircle: CircleView!
    
    @IBOutlet weak var safeZone: UIView!
    
    // Constraints
    @IBOutlet weak var numberToNameLeadingConstraint: NSLayoutConstraint!
    var numberToNameLeadingProgConstraint : NSLayoutConstraint?
    
    @IBOutlet weak var nameToNumberTopConstraint: NSLayoutConstraint!
    var nameToNumberTopProgConstraint : NSLayoutConstraint?
    
    @IBOutlet weak var nameLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var numberTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var numberLeadingConstraint: NSLayoutConstraint!
    
    var numberWidthAnchorProgConstraint : NSLayoutConstraint?
    
    @IBOutlet weak var nameBottomToSuperviewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var safeZoneWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var paymentMethodImageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cardBalanceContainer: CardBalance!

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
        
        modifyCardPattern()
        
        layoutIfNeeded()
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
        securityCode.isHidden = true
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
    
    func setSafeZoneConstraints () {
        name.isHidden = true
        
        numberTrailingConstraint.isActive = false
        
        numberLeadingConstraint.isActive = true
        
        number.textAlignment = .left
        
        // Make SafeZone visible and add customView
        
        if let customView = customView {
            safeZone.addSubview(customView)
            
            customView.pinEdges(to: safeZone)
            
            safeZone.isHidden = false
            safeZoneWidthConstraint.isActive = true
        }
    }
    
    func modifyCardPattern() {
        // Number width change
        
        if let cardUI = cardUI, cardUI.cardPattern.count > 0 {
            
            number.adjustsFontSizeToFitWidth = false
            number.lineBreakMode = .byClipping
            
            number.font = number.font.withSize(16)
            
            number.textAlignment = .right
            
            var modifiedCardPattern : [Int], modifiedNumber : String, charCount : Int
            
            if cardUI.cardPattern.count > 2 || (cardUI.cardPattern.count == 2 && cardUI.cardPattern.reduce(0,+) > 12) {
                
                let font = number.font
                // If card pattern is still bigger than two it will be modified
                // If the last group is bigger than 6 chars use this one only, if not use last two groups
                let offset = cardUI.cardPattern[cardUI.cardPattern.count - 1] > 6 ? 1 : 2
                
                // Get only the last two groups of numbers
                let range = cardUI.cardPattern.index(cardUI.cardPattern.endIndex, offsetBy: -1 * offset) ..< cardUI.cardPattern.endIndex
                
                modifiedCardPattern = Array(cardUI.cardPattern[range])
                
                cardUI.cardPattern = modifiedCardPattern
                
                modifiedNumber = model?.number ?? ""
                
                charCount = modifiedCardPattern.reduce(0, +)
                
                // Get only the last parts of cardNumber
                if let cardNumber = model?.number, cardNumber.count > charCount {
                    let numberRange = cardNumber.index(cardNumber.endIndex, offsetBy: charCount * -1) ..< cardNumber.endIndex
                    modifiedNumber = String(cardNumber[numberRange])
                }
                
            } else {
                modifiedNumber = model?.number ?? ""
                
                modifiedCardPattern = cardUI.cardPattern
                
                charCount = modifiedCardPattern.reduce(0, +)
            }
            
            let slices = min(max(modifiedCardPattern.count - 1, 0), 1)
            
            let totalChars = slices + charCount
            
            let kerning = number.formatter.attributes[.kern] as? Double ?? 0.0
            
            let width = CGFloat(totalChars) * number.font.size(" ", kerning: kerning).width
            
            numberWidthAnchorProgConstraint = number.widthAnchor.constraint(equalToConstant: CGFloat(width))
            
            numberWidthAnchorProgConstraint?.isActive = true
            
            number.layoutIfNeeded()
            
            number.formatter = Mask(pattern: modifiedCardPattern, digits: modifiedNumber)
            
            model?.number = modifiedNumber
        }
        
    }
    
    func clearSafeZoneConstraints() {
        safeZoneWidthConstraint.isActive = false
        
        name.isHidden = false
        
        numberTrailingConstraint.isActive = true
        
        numberLeadingConstraint.isActive = false
        
        number.textAlignment = .right
        
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
                             views: [bankImage, expirationDate, paymentMethodImage, name, number, securityCode],
                             complete: {[weak self] in
                                self?.setupUI(cardUI)
            })
        }
    }

    public override func showSecurityCode() {
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
                    self.setImageScalingImageView(image, inImageView: self.paymentMethodImage)
                }
            }
        } else if let image = cardUI.cardLogoImage as? UIImage {
            setImageScalingImageView(image, inImageView: paymentMethodImage)
        }
        
        if let paymentMethodImage = self.paymentMethodImage as? UIImageViewAligned {
            paymentMethodImage.alignLeft = true
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

        let ratio = tImage.size.width / tImage.size.height
        let newWidth = inImageView.frame.height * ratio
        paymentMethodImageWidthConstraint.constant = newWidth
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

