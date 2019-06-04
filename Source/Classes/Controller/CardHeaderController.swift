import UIKit

@objcMembers public class MLCardDrawerController: UIViewController {
    private var shouldAnimate: Bool = true
    let cardFont = "RobotoMono-Regular"
    var frontView = FrontView()
    var backView = BackView()

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

    public init(_ cardUI: CardUI, _ model: CardData, _ disabledMode: Bool = false) {
        self.cardUI = cardUI
        UIFont.registerFont(fontName: cardFont, fontExtension: "ttf")
        super.init(nibName: nil, bundle: nil)
        backView.setup(cardUI, model, view.frame, disabledMode)
        frontView.setup(cardUI, model, view.frame, disabledMode)
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
        inView.layoutIfNeeded()
        view.frame = CGRect(origin: .zero, size: inView.frame.size)
        inView.addSubview(view)
        return self
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
        subview.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)
        view.addSubview(subview)
    }
}
