import UIKit

class BasePaymentMethodInfoCard: UIView, BasicCard {
    
    var splitCardUI: SplitCardUI?
    var isDisabled: Bool = false
    
    var container: UIView = UIView()
    var pan: PANView = PANView()
    var paymentType: UILabel = UILabel()
    var entity: UILabel = UILabel()
    var amount: UILabel = UILabel()
    var overlay: UIImageView = UIImageView()
    var gradient: UIView = UIView()
    
    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool, customLabelFontName: String?) {
        self.frame = frame
        self.isDisabled = isDisabled
        layer.masksToBounds = true
        layer.isDoubleSided = false
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        setupUI(cardUI)
        setupConstraints()
    }
    
    func setupUI(_ cardUI: CardUI) {
        if let cardUI = cardUI as? SplitCardUI {
            splitCardUI = cardUI
        }
        setupContainer()
        setupOverlay()
        setupGradient()
        setupPAN()
        setupPaymentType()
        setupEntity()
        setupAmount()
    }
    
    
    func setupContainer() {
//        container.frame = CGRect(x: 0, y: 0, width: 320.0, height: 97.0)
        container.backgroundColor = splitCardUI?.cardBackgroundColor
    }
    
    func setupOverlay() {
        overlay.image = UIImage(named: "Overlay", in: MLCardDrawerBundle.bundle(), compatibleWith: nil)

//        overlay.frame = CGRect(x: 0, y: 0, width: 320.0, height: 97.0)
    }
    
    func setupGradient() {
        let layer = CAGradientLayer()
        let end = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        layer.colors = [UIColor.black.cgColor, end]
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0, y: 1)
        layer.endPoint = CGPoint(x: 1, y: 0)
        self.gradient.layer.compositingFilter = "overlayBlendMode"
        self.gradient.layer.addSublayer(layer)
    }
    
    func setupPAN() {
        pan.render()
        pan.setNumber("1234", withPad: true)
        //        pan.setPANStyle(splitCardUI, isDisabled)
    }
    
    func setupPaymentType() {
        paymentType.font = .proximaNovaRegular(size: 14.0)
        paymentType.textAlignment = .right
        paymentType.text = "Crédito Crédito Crédito Crédito Crédito Crédito Crédito Crédito Crédito Crédito Crédito Crédito"
        paymentType.textColor = .white
    }
    
    func setupEntity() {
        entity.font = .proximaNovaSemibold(size: 14.0)
        entity.textAlignment = .left
        entity.text = "Nubank Nubank Nubank Nubank Nubank Nubank Nubank Nubank Nubank Nubank "
        entity.textColor = .white

    }
    
    func setupAmount() {
        amount.font = .proximaNovaSemibold(size: 16.0)
        amount.textAlignment = .right
        amount.text = "1x R$ 10000000000"
        amount.textColor = .white
    }
    
    func setupConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        overlay.translatesAutoresizingMaskIntoConstraints = false
        gradient.translatesAutoresizingMaskIntoConstraints = false
        pan.translatesAutoresizingMaskIntoConstraints = false
        paymentType.translatesAutoresizingMaskIntoConstraints = false
        entity.translatesAutoresizingMaskIntoConstraints = false
        amount.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(container)
        self.addSubview(overlay)
        self.addSubview(gradient)
        container.addSubview(pan)
        container.addSubview(paymentType)
        container.addSubview(entity)
        container.addSubview(amount)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            overlay.topAnchor.constraint(equalTo: self.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            overlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            gradient.topAnchor.constraint(equalTo: self.topAnchor),
            gradient.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            gradient.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            pan.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.0),
            pan.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.0),
            
            paymentType.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.0),
            paymentType.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.0),
            paymentType.widthAnchor.constraint(equalToConstant: 195.0),
            
            entity.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.0),
            entity.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.0),
            entity.trailingAnchor.constraint(equalTo: container.centerXAnchor, constant: -4.0),
            
            amount.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.0),
            amount.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.0),
            amount.leadingAnchor.constraint(equalTo: container.centerXAnchor, constant: 4.0)
        ])
    }
    
    func addShineView() { }
    
    func removeShineView() { }
    
    func removeGradient() { }
    
    func addGradient() { }
    
    func addCardBalance(_ model: CardBalanceModel, _ showBalance: Bool, _ delegate: CardBalanceDelegate) { }
    
    func setupAnimated(_ cardUI: CardUI) { }
    
    
    func isShineEnabled() -> Bool {
        return false
    }
}


