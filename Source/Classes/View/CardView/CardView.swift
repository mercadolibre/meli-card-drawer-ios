import UIKit

@objc protocol CardViewInteractProtocol {
    @objc func setupAnimated(_ cardUI: CardUI)
    
    @objc optional func showSecurityCode()
}

class CardView: UIView {

    @IBOutlet weak var animation: UIView!
    @IBOutlet weak var gradient: UIView!
    @IBOutlet weak var securityCode: CardLabel!
    @IBOutlet weak var overlayImage: UIImageView!
    
    private var shineView: ShineView?
    var cardBackground: UIColor = .clear
    
    let disabledGray: UIColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
    var color: UIColor?
    var disabledMode: Bool = false
    @objc var model: CardData?
    private var cardUI: CardUI?


    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool = false) {
        self.frame = frame
        layer.masksToBounds = true
        layer.isDoubleSided = false
        disabledMode = isDisabled
        loadFromNib()
        setupModel(model)
        setupUI(cardUI)
        addGradient()
        
        if isShineEnabled() {
            addShineView()
        }
    }

    init() {
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(_ cardUI: CardUI) {
        self.cardUI = cardUI
        if !(cardUI is CustomCardDrawerUI) {
            let mainColor = disabledMode ? disabledGray : cardUI.cardBackgroundColor
            animation.backgroundColor = mainColor
        }
    }

    func setupModel(_ model: CardData) {
        self.model = model
        addObservers()
    }

    func addObservers() {
        addObserver(securityCode, forKeyPath: #keyPath(model.securityCode), options: .new, context: nil)
    }
    
    private func setupImage(image: UIImage?, disabledMode: Bool) -> UIImage? {
        if disabledMode {
            return image?.imageGreyScale()
        }
        return image
    }
    
    func setupCardLogo(in container: UIImageView) {
        if let cardLogoImage = cardUI?.cardLogoImage {
            container.image = setupImage(image: cardLogoImage, disabledMode: disabledMode)
        }

        cardUI?.set?(logo: container)
    }
    
    func setupBankImage(in container: UIImageView) {
        if let bankImage = cardUI?.bankImage {
            container.image = setupImage(image: bankImage, disabledMode: disabledMode)
        }

        cardUI?.set?(bank: container)
    }
}

// MARK: Card View Effects

extension CardView {
    func removeGradient() {
        guard let sublayers = gradient.layer.sublayers else { return }
        for targetSubLayer in sublayers {
            targetSubLayer.removeFromSuperlayer()
            targetSubLayer.removeAllAnimations()
        }
    }

    func addGradient() {
        if let currentCardUI = cardUI, let customCardUI = currentCardUI as? CustomCardDrawerUI {
            if let customGradient = customCardUI.ownGradient {
                customGradient.frame = frame
                self.gradient.layer.addSublayer(customGradient)
            } else {
                // Default gradient for custom card.
                let gradient = CAGradientLayer()
                gradient.frame = frame
                let mainColor = disabledMode ? disabledGray.cgColor : customCardUI.cardBackgroundColor.cgColor
                gradient.colors = [mainColor, UIColor.white.cgColor]
                gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradient.endPoint = CGPoint(x: 1.6, y: 0.5)
                self.gradient.layer.addSublayer(gradient)
            }
        } else {
            // Our default card gradients
            let layer = CAGradientLayer()
            let end = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
            layer.colors = [UIColor.black.cgColor, end]
            layer.frame = frame
            layer.startPoint = CGPoint(x: 0, y: 1)
            layer.endPoint = CGPoint(x: 1, y: 0)
            self.gradient.layer.addSublayer(layer)
            self.gradient.layer.compositingFilter = "overlayBlendMode"
        }
    }
    
    public func isShineEnabled() -> Bool {
        return shineView != nil
    }
    
    public func addShineView() {
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
    public func removeShineView() {
        shineView?.removeMotionEffects()
        shineView?.removeFromSuperview()
        shineView = nil
    }
    
    func setupCustomOverlayImage(_ cardUI: CardUI) {
        if let customOverlayImage = cardUI.ownOverlayImage {
            overlayImage.image = customOverlayImage
        }
    }
}

extension CardView: CardViewInteractProtocol {
    func setupAnimated(_ cardUI: CardUI) {}
    public func showSecurityCode() {}
}
