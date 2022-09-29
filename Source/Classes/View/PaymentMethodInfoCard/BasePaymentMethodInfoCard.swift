import UIKit

class BasePaymentMethodInfoCard: UIView, BasicCard {
    
    // MARK: - Models
    var paymentMethodInfoCardUI: PaymentMethodInfoCardUI?
    var paymentMethodInfoCardData: CardData?
    
    // MARK: - Properties
    var disabledMode: Bool = false
    
    // MARK: - Views
    lazy var container: UIView = {
        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var gradient: UIView = {
        gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        return gradient
    }()
    
    lazy var overlay: UIImageView = {
        overlay = UIImageView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        return overlay
    }()
    
    lazy var entity: UILabel = {
        entity = UILabel()
        entity.translatesAutoresizingMaskIntoConstraints = false
       return entity
    }()
    
    lazy var amount: UILabel = {
        amount = UILabel()
        amount.translatesAutoresizingMaskIntoConstraints = false
        return amount
    }()
    
    lazy var pan: PANView = {
        pan = PANView()
        pan.translatesAutoresizingMaskIntoConstraints = false
        return pan
    }()
    
    lazy var paymentType: UILabel = {
        paymentType = UILabel()
        paymentType.translatesAutoresizingMaskIntoConstraints = false
        return paymentType
    }()
    
    // MARK: - Constants
    enum Constants {
        static let gradientImage = UIImage(named: "Overlay", in: MLCardDrawerBundle.bundle(), compatibleWith: nil)
        
        static let entityFontSize = 14.0
        static let amountFontSize = 16.0
        static let paymentTypeFontSize = 14.0
    }
    
    enum ConstraintValues {
        static let entityLeadingAnchor: Double = 16
        static let entityTopAnchor: Double = 16
        static let entityTrailingAnchor: Double = -4
    
        static let amountLeadingAnchor: Double = 4
        static let amountTopAnchor: Double = 16
        static let amountTrailingAnchor: Double = -16
        
        static let panLeadingAnchor: Double = 16
        static let panBottomAnchor: Double = -16
        
        static let paymentTypeTrailingAnchor: Double = -16
        static let paymentTypeBottomAnchor: Double = -16
        static let paymentTypeWidthAnchor: Double = 195
    }
    
    // MARK: - Main setup
    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool, customLabelFontName: String?) {
        self.frame = frame
        self.disabledMode = isDisabled
        self.paymentMethodInfoCardData = model
        self.paymentMethodInfoCardUI = cardUI as? PaymentMethodInfoCardUI
        setupUI(cardUI)
        setupConstraints()
    }
    
    func setupUI(_ cardUI: CardUI) {
        setupContainer()
        setupGradient()
        setupOverlay()
        setupEntity()
        setupAmount()
        setupPAN()
        setupPaymentType()
        
        setupCornerRadius()
        layer.masksToBounds = true
        layer.isDoubleSided = false
    }
    // MARK: - Components
    func setupContainer() {
        container.frame = frame
        container.backgroundColor = paymentMethodInfoCardUI?.cardBackgroundColor
    }
    
    func setupGradient() {
        if let customGradient = paymentMethodInfoCardUI?.gradient {
            customGradient.frame = bounds
            gradient.layer.addSublayer(customGradient)
        } else {
            let layer = CAGradientLayer()
            let end = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
            layer.colors = [UIColor.black.cgColor, end]
            layer.frame = bounds
            layer.startPoint = CGPoint(x: 0, y: 1)
            layer.endPoint = CGPoint(x: 1, y: 0)
            gradient.layer.compositingFilter = "overlayBlendMode"
            gradient.layer.addSublayer(layer)
        }
    }
    
    func setupOverlay() {
        overlay.backgroundColor = .clear
        overlay.contentMode = .scaleToFill
        if let customOverlay = paymentMethodInfoCardUI?.overlay {
            overlay.image = customOverlay }
        else { overlay.image = Constants.gradientImage }
    }
    
    func setupEntity() {
        entity.text = paymentMethodInfoCardUI?.entity?.message
        entity.textColor = paymentMethodInfoCardUI?.entity?.textColor ?? .white
        entity.font = .proximaNovaSemibold(size: Constants.entityFontSize)
        entity.textAlignment = paymentMethodInfoCardUI?.entity?.alignment ?? .left
        entity.backgroundColor = paymentMethodInfoCardUI?.entity?.backgroundColor ?? .clear
    }
    
    func setupAmount() {
        amount.text = paymentMethodInfoCardUI?.amount?.message
        amount.textColor = paymentMethodInfoCardUI?.amount?.textColor ?? .white
        amount.font = .proximaNovaSemibold(size: Constants.amountFontSize)
        amount.textAlignment = paymentMethodInfoCardUI?.amount?.alignment ?? .right
        amount.backgroundColor = paymentMethodInfoCardUI?.amount?.backgroundColor ?? .clear
    }

    func setupPAN() {
        pan.cardUI = paymentMethodInfoCardUI as? CardUI
        let number = paymentMethodInfoCardData?.number ?? ""
        let length = paymentMethodInfoCardUI?.cardPattern.reduce(0, +)
        
        if !pan.isRendered() { pan.render() }
        if number.count == 0 { pan.isHidden = true } // Aca validar que este el icono
        if number.count == length,
           number.count >= 4 {
            pan.setNumber(String(number.suffix(4)), withPad: true)
        }
        
        if let cardUI = pan.cardUI {
            pan.setPANStyle(cardUI, disabledMode)
        }
    }
    
    func setupPaymentType() {
        paymentType.text = paymentMethodInfoCardUI?.paymentType?.message
        paymentType.textColor = paymentMethodInfoCardUI?.paymentType?.textColor ?? .white
        paymentType.font = .proximaNovaRegular(size: Constants.paymentTypeFontSize)
        paymentType.textAlignment = paymentMethodInfoCardUI?.paymentType?.alignment ?? .right
        paymentType.backgroundColor = paymentMethodInfoCardUI?.paymentType?.backgroundColor ?? .clear
    }
    
    func setupCornerRadius() {
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        self.addSubview(container)
        container.addSubview(gradient)
        container.addSubview(overlay)
        container.addSubview(entity)
        container.addSubview(amount)
        container.addSubview(pan)
        container.addSubview(paymentType)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            gradient.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradient.topAnchor.constraint(equalTo: self.topAnchor),
            gradient.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            gradient.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            overlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            overlay.topAnchor.constraint(equalTo: self.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            overlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            entity.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: ConstraintValues.entityLeadingAnchor),
            entity.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.entityTopAnchor),
            entity.trailingAnchor.constraint(equalTo: container.centerXAnchor, constant: ConstraintValues.entityTrailingAnchor),
            
            amount.leadingAnchor.constraint(equalTo: container.centerXAnchor, constant: ConstraintValues.amountLeadingAnchor),
            amount.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.amountTopAnchor),
            amount.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.paymentTypeTrailingAnchor),
            
            pan.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: ConstraintValues.panLeadingAnchor),
            pan.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.panBottomAnchor),
            
            paymentType.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.paymentTypeBottomAnchor),
            paymentType.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.paymentTypeTrailingAnchor),
            paymentType.widthAnchor.constraint(equalToConstant: ConstraintValues.paymentTypeWidthAnchor)
        ])
    }
    
    // MARK: - Protocol conformance
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
