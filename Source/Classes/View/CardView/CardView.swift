import UIKit

class CardView: UIView {

    @IBOutlet weak var animation: UIView!
    @IBOutlet weak var gradient: UIView!
    @IBOutlet weak var securityCode: CardLabel!
    @objc var model: CardData?
    var color: UIColor?

    let cornerRadius: CGFloat = 11

    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect) {
        self.frame = frame
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.isDoubleSided = false
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
        securityCode.formatter = Mask(pattern: [cardUI.securityCodePattern])        
        animation.backgroundColor = cardUI.cardBackgroundColor
    }

    func setupModel(_ model: CardData) {
        self.model = model
        addObservers()
    }

    func addObservers() {
        addObserver(securityCode, forKeyPath: #keyPath(model.securityCode), options: .new, context: nil)
    }

    func addGradient() {
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
