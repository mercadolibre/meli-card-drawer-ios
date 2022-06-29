import UIKit

@objc(MLCardView)
public class CardView: UIView, BasicCard {

    @IBOutlet weak var animation: UIView!
    @IBOutlet weak var gradient: UIView!
    @IBOutlet weak var securityCode: CardLabel!
    @IBOutlet weak var overlayImage: UIImageView!
    
    private var shineView: ShineView?
    var cardBackground: UIColor = .clear
    var customLabelFontName: String?
    let disabledGray: UIColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
    var color: UIColor?
    var disabledMode: Bool = false
    @objc var model: CardData?
    var cardUI: CardUI?
    
    public var customView : UIView?

    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool = false, customLabelFontName: String? = nil) {
        self.frame = frame
        layer.masksToBounds = true
        layer.isDoubleSided = false
        disabledMode = isDisabled
        self.customLabelFontName = customLabelFontName
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
            if let customGradient = customCardUI.ownGradient, let isExperiment = customCardUI.isExperiment {
                customGradient.frame = frame
                if isExperiment {
                    animatedGradient(customGradient)
                } else {
                    self.gradient.layer.addSublayer(customGradient)
                }
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
    
    func animatedGradient(_ customGradient: CAGradientLayer) {
        
        let ovalSize = CGSize(width: 334.0 * 2, height: 206.5 * 2)
        let ovalOrigin = CGPoint(x: -334.0 * 2, y: -206.5 * 2)
        let toPath = UIBezierPath.init(ovalIn: CGRect(origin: CGPoint.zero, size: ovalSize)).cgPath
        let fromPath = UIBezierPath.init(ovalIn: CGRect(origin: ovalOrigin, size: ovalSize)).cgPath

        let layer = CAShapeLayer()
        layer.path = fromPath
        layer.bounds = self.gradient.layer.frame
        layer.fillColor = cardUI?.cardBackgroundColor.cgColor
        customGradient.mask = layer
        self.gradient.layer.addSublayer(customGradient)

        CATransaction.begin()
        CATransaction.setAnimationDuration(0.4)
        let timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        CATransaction.setAnimationTimingFunction(timingFunction)

        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.toValue = toPath
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = CAMediaTimingFillMode.forwards
        layer.add(pathAnimation, forKey: nil)

        CATransaction.commit()
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
            overlayImage.alpha = (cardUI as? CustomCardDrawerUI)?.isExperiment ?? false ? 0 : 1
            overlayImage.image = customOverlayImage

            UIView.animate(withDuration: 0.8, delay: 0.5, options: .curveEaseOut, animations: {
                self.overlayImage.alpha = 1.0
            }, completion: nil)
        }
    }
}

extension CardView: CardViewCustomViewProtocol{
    func removeCustomView() {}
    func addCustomView(_ customView: UIView) {}
}

extension CardView: CardViewInteractProtocol {
    func setupAnimated(_ cardUI: CardUI) {}
    public func showSecurityCode() {}
}
