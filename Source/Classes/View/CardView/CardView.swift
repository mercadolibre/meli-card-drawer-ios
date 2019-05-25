import UIKit

class CardView: UIView {

    @IBOutlet weak var animation: UIView!
    @IBOutlet weak var gradient: UIView!
    @IBOutlet weak var securityCode: CardLabel!
    let disabledGray: UIColor = #colorLiteral(red: 0.2862745098, green: 0.2862745098, blue: 0.2862745098, alpha: 1)
    let cornerRadius: CGFloat = 11
    var color: UIColor?
    var disabledMode: Bool = false
    @objc var model: CardData?

    private var cardUI: CardUI?

    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool = false) {
        self.frame = frame
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.isDoubleSided = false
        disabledMode = isDisabled
        loadFromNib()
        setupModel(model)
        setupUI(cardUI)
        addGradient()
    }

    init() {
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(_ cardUI: CardUI) {
        self.cardUI = cardUI
        securityCode.formatter = Mask(pattern: [cardUI.securityCodePattern])
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

    func addGradient() {
        if let currentCardUI = cardUI, let customCardUI = currentCardUI as? CustomCardDrawerUI {
            if let customGradient = customCardUI.ownGradient {
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
}
