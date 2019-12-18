import UIKit

@objcMembers public class MLCardDrawerController: UIViewController {
    private var shouldAnimate: Bool = true
    let cardFont = "RobotoMono-Regular"
    var frontView: CardView!
    var backView: CardView!
    var model: CardData
    private var type: MLCardDrawerType = .large
    private var disabledMode = false
    
    private var aspectLayoutConstraint: NSLayoutConstraint?

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var cardUI: CardUI {
        willSet(value) {
            if shouldAnimate {
                frontView.setupAnimated(value)
            } else {
                frontView.setupUI(value)
            }
            if isShineCardEnabled() {
                addShine()
            }
            backView.setupUI(value)
        }
    }
    
    public convenience init(_ cardUI: CardUI, _ model: CardData, _ disabledMode: Bool = false) {
        self.init(cardUI, model, disabledMode, .large)
    }

    public init(_ cardUI: CardUI, _ model: CardData, _ disabledMode: Bool = false, _ type: MLCardDrawerType = .large) {
        self.cardUI = cardUI
        UIFont.registerFont(fontName: cardFont, fontExtension: "ttf")
        self.model = model
        self.type = type
        self.disabledMode = disabledMode
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    public func setupViews() {
        
        if let frontView = frontView, frontView.isDescendant(of: view) {
            frontView.removeFromSuperview()
        }
        
        if let backView = backView, backView.isDescendant(of: view) {
            backView.removeFromSuperview()
        }
    
        setupView(type)
        
        backView.setup(cardUI, model, view.frame, disabledMode)
        frontView.setup(cardUI, model, view.frame, disabledMode)
        
        setShineCard(enabled: isShineCardEnabled())
    }
    
    
    private func setupView(_ type: MLCardDrawerType) {
        switch type {
        case .large:
            backView = BackView()
            frontView = FrontView()
        case .medium:
            backView = MediumBackView()
            frontView = MediumFrontView()
            
        case .small:
            backView = SmallBackView()
            frontView = SmallFrontView()
        }
    }

    public func show() {
        transition(from: backView, to: frontView, .transitionFlipFromRight)
    }

    public func animated(_ animated: Bool) {
        shouldAnimate = animated
    }

    public func showSecurityCode() {
        guard cardUI.securityCodeLocation == .back else {
            addSubview(frontView)
            frontView.showSecurityCode()
            return
        }
        transition(from: frontView, to: backView, .transitionFlipFromLeft)
    }

    @discardableResult
    public func setUp(inView: UIView) -> MLCardDrawerController {
        self.aspectLayoutConstraint?.isActive = false
        inView.layoutIfNeeded()
        view.frame = CGRect(origin: .zero, size: inView.frame.size)
        inView.addSubview(view)
        return self
    }
    
    
    public func getCardView() -> UIView {
        self.aspectLayoutConstraint?.isActive = false
        let aspectLayoutConstraint = view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: CardSizeManager.getGoldenRatio(from: type))
        aspectLayoutConstraint.isActive = true
        setupViews()
        self.aspectLayoutConstraint = aspectLayoutConstraint
        show()
        return view
    }
}

// MARK: Shine card feature.
extension MLCardDrawerController {
    public func setShineCard(enabled: Bool) {
        if enabled {
            addShine()
        } else {
            removeShine()
        }
    }

    public func isShineCardEnabled() -> Bool {
        return frontView.isShineEnabled()
    }

    private func addShine() {
        removeShine()
        frontView.removeGradient()
        frontView.addShineView()
    }

    private func removeShine() {
        frontView.addGradient()
        frontView.removeShineView()
    }
}

// MARK: Internals
extension MLCardDrawerController {
    func transition(from origin: UIView, to destination: UIView, _ options: UIView.AnimationOptions) {
        addSubview(destination)
        Animator.flip(origin, destination, options)
    }

    func addSubview(_ subview: UIView) {
        if let aspectConstraint = aspectLayoutConstraint, aspectConstraint.isActive == true {
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
            subview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            subview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            subview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            subview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        } else {
            subview.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)
            view.addSubview(subview)
        }
    }
}
