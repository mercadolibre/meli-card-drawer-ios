import UIKit

@objcMembers public class CardHeaderController: UIViewController {
    let cardFont = "RobotoMono-Regular"
    var frontView = FrontView()
    var backView = BackView()

    public var cardUI: CardUI {
        willSet(value) {
            frontView.setupAnimated(value)
            backView.setupUI(value)
        }
    }

    public init(_ cardUI: CardUI, _ model: CardData) {
        self.cardUI = cardUI
        UIFont.registerFont(fontName: cardFont, fontExtension: "ttf")
        super.init(nibName: nil, bundle: nil)
        backView.setup(cardUI, model, view.frame)
        frontView.setup(cardUI, model, view.frame)
    }

    public func show() {
        transition(from: backView, to: frontView, .transitionFlipFromRight)
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
    public func setup(inView: UIView) -> CardHeaderController {
        inView.layoutIfNeeded()
        view.frame = CGRect(origin: .zero, size: inView.frame.size)
        inView.addSubview(view)
        return self
    }

    func transition(from origin: UIView, to destination: UIView, _ options: UIView.AnimationOptions) {
        addSubview(destination)
        Animator.flip(origin, destination, options)
    }

    func addSubview(_ subview: UIView) {
        subview.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)
        view.addSubview(subview)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
