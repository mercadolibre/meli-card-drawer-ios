
public class BaseCardView: UIView, BasicCard {
    
    @IBOutlet weak var animation: UIView!
    @IBOutlet weak var gradient: UIView!
    @IBOutlet weak var highlightTagBottomView: UIView!
    @IBOutlet weak var highlightTagBottonLabel: UILabel!
    @IBOutlet weak var securityCode: CardLabel!
    
    private var shineView: ShineView?
    
    var cardBackground: UIColor = .clear
    var customLabelFontName: String?
    let disabledGray: UIColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
    var color: UIColor?
    var disabledMode: Bool = false
    @objc var model: CardData?
    var cardUI: CardUI?
    
    public var customView : UIView?
    
    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool, customLabelFontName: String?) {
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
    
    func setupModel(_ model: CardData) {
        self.model = model
        addObservers()
    }
    
    func addObservers() {
        addObserver(securityCode, forKeyPath: #keyPath(model.securityCode), options: .new, context: nil)
    }
    
    func setupUI(_ cardUI: CardUI) {
        self.cardUI = cardUI
        if !(cardUI is CustomCardDrawerUI) {
            let mainColor = disabledMode ? disabledGray : cardUI.cardBackgroundColor
            animation.backgroundColor = mainColor
        }
    }
    
    func isShineEnabled() -> Bool {
        return shineView != nil
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
    
    func removeGradient() {}
    
    func addGradient() {
            if let currentCardUI = cardUI, let customCardUI = currentCardUI as? CustomCardDrawerUI {
                if let customGradient = customCardUI.ownGradient {
                    let gradient = CAGradientLayer()
                    gradient.frame = frame
                    gradient.colors = customGradient.colors
                    gradient.startPoint = customGradient.startPoint
                    gradient.endPoint = customGradient.endPoint
                    self.gradient.layer.addSublayer(gradient)
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
    
    func addCardBalance(_ model: CardBalanceModel, _ showBalance: Bool, _ delegate: CardBalanceDelegate) {}
    
    func toggleCardBalance() {}
    
    func isCardBalanceHidden() -> Bool { false }
    
    public func addTagBottom(containerView: UIView, isDisabled: Bool, cardType: MLCardDrawerTypeV3, tagBottom: Text?, padding: UIEdgeInsets = .zero) {
            if cardType.rawValue >= MLCardDrawerTypeV3.small.rawValue {
                if let tagBottom = tagBottom{
                    let customlabelTagBottom = CardView.createTagBottom(tagBottom)
                    containerView.addSubview(highlightTagBottomView)
                    highlightTagBottomView.backgroundColor = customlabelTagBottom.backgroundColor
                    highlightTagBottonLabel.text = customlabelTagBottom.text
                    highlightTagBottonLabel.textColor = customlabelTagBottom.textColor
                    
                    highlightTagBottomView.bottomTagAlignment(top: nil,
                                                          leading: nil,
                                                          trailing: trailingAnchor,
                                                          bottom: bottomAnchor,
                                                                padding: padding,
                                                              size: CGSize(width: highlightTagBottonLabel.intrinsicContentSize.width + ConstantsValues.spacingWidth, height: ConstantsValues.heightBottom))

                    highlightTagBottonLabel.bottomTagAlignment(top: nil,
                                                          leading: nil,
                                                          trailing: trailingAnchor,
                                                          bottom: bottomAnchor,
                                                               padding: padding,
                                                               size: CGSize(width: highlightTagBottonLabel.intrinsicContentSize.width + ConstantsValues.sideSpacing, height: ConstantsValues.heightBottom))
                    highlightTagBottomView.roundCorners(cornerRadiuns: 12, typeCorners: [.topLeft,.lowerLeft])
             }
        }
    }
}

extension BaseCardView: CardViewCustomViewProtocol {
        func removeCustomView() {}
        func addCustomView(_ customView: UIView) {}
    }

extension BaseCardView: CardViewInteractProtocol {
        func setupAnimated(_ cardUI: CardUI) {}
        public func showSecurityCode() {}
}
