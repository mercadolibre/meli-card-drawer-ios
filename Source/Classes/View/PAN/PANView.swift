import UIKit

class PANView: UIView {
    
    enum PANLabelUI {
        static let labelPlaceHolder = "•••• ••••"
        static let labelTextColor: UIColor = .white
        static let labelBackgroundColor: UIColor = .clear
        static let labelFontSize: CGFloat = 14.0
        static let topPadding: CGFloat = 4.0
        static let bottomPadding: CGFloat = -4.0
        static let leadingPadding: CGFloat = 8.0
        static let trailingPadding: CGFloat = -8.0
        static let labelDisabledTextColor: UIColor = .fromHex("#F0F0F0")
        static let labelLength = 8
        static let labelConstraintPriority: Float = 998
    }
    
    enum PANIssuerLogoContainerUI {
        static let issuerContainerHeight = 15.0
        static let topPadding: CGFloat = 4.0
        static let bottomPadding: CGFloat = -4.0
        static let leadingPadding: CGFloat = 8.0
        static let trailingPadding: CGFloat = -8.0
        static let trailingPaddingWithLabel: CGFloat = -4.0
    }
    
    enum PANContainerUI {
        static let containerBackgroundColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
        static let containerCornerRadius: CGFloat = 4.0
        static let containerDisabledColor: UIColor = .fromHex("#A0A0A0")
    }
    
    var PANLabel: UILabel!
    var PANContainer: UIView!
    var PANIssuerLogoContainer: UIImageView = {
        let container = UIImageView()
        container.contentMode = .scaleAspectFit
        container.clipsToBounds = true
        container.sizeToFit()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.setContentHuggingPriority(.required, for: .horizontal)
        container.setContentCompressionResistancePriority(.required, for: .horizontal)
        return container
    }()

    var cardUI: CardUI?
    
    public init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func render() {
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        setupLabel()
        setupContainer()
    }
    
    private func setupLabel() {
        PANLabel = UILabel()
        PANLabel.font = .proximaNovaSemibold(size: PANLabelUI.labelFontSize)
        PANLabel.backgroundColor = PANLabelUI.labelBackgroundColor
        PANLabel.textColor = PANLabelUI.labelTextColor
        PANLabel.text = PANLabelUI.labelPlaceHolder
        PANLabel.clipsToBounds = true
        PANLabel.sizeToFit()
        PANLabel.translatesAutoresizingMaskIntoConstraints = false
        PANLabel.setContentHuggingPriority(.required, for: .horizontal)
        PANLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func setupContainer() {
        PANContainer = UIView()
        PANContainer.backgroundColor = PANContainerUI.containerBackgroundColor
        PANContainer.layer.cornerRadius = PANContainerUI.containerCornerRadius
        PANContainer.clipsToBounds = true
        PANContainer.sizeToFit()
        PANContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        self.addSubview(PANContainer)
        PANContainer.addSubview(PANLabel)
                
        let labelTrailingAnchorConstraint = PANLabel.trailingAnchor.constraint(equalTo: PANContainer.trailingAnchor, constant: PANLabelUI.trailingPadding)
        labelTrailingAnchorConstraint.priority = UILayoutPriority(PANLabelUI.labelConstraintPriority)
        
        let labelLeadingAnchorConstraint = PANLabel.leadingAnchor.constraint(equalTo: PANContainer.leadingAnchor, constant: PANLabelUI.leadingPadding)
        labelLeadingAnchorConstraint.priority = UILayoutPriority(PANLabelUI.labelConstraintPriority)
        
        NSLayoutConstraint.activate([
            PANContainer.topAnchor.constraint(equalTo: self.topAnchor),
            PANContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            PANContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            PANContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            PANLabel.topAnchor.constraint(equalTo: PANContainer.topAnchor, constant: PANLabelUI.topPadding),
            PANLabel.bottomAnchor.constraint(equalTo: PANContainer.bottomAnchor, constant: PANLabelUI.bottomPadding),
            labelTrailingAnchorConstraint,
            labelLeadingAnchorConstraint
        ])
    }
}

extension PANView {
    
    public func isRendered() -> Bool {
        return self.PANLabel != nil && self.PANContainer != nil
    }
    
    public func setNumber(_ number: String, withPad: Bool = false) {
        PANLabel.text = withPad ? "•••• " + number : number
    }
    
    public func setPANStyle(_ cardUI: CardUI, _ disabled: Bool = false) {
        guard self.isRendered() == true else { return }
        
        if let panStyle = cardUI.panStyle {
            
            if let message = panStyle?.message {
                setMessage(message)
            }
            
            if let issuerLogoUrl = panStyle?.issuerLogoUrl {
                setIssuerLogo(issuerLogoUrl)
            }
            
            if let backgroundColor = panStyle?.backgroundColor {
                setBackgroundColor(backgroundColor)
            }
            
            if let textColor = panStyle?.textColor {
                setTextColor(textColor)
            }
            
            if let weight = panStyle?.weight {
                setWeight(weight)
            }
        }
        
        if disabled {
            setDisabledStyle()
        }
    }
    
    private func setMessage(_ message: String) {
        PANLabel.text = message
    }
    
    private func setIssuerLogo(_ url: String) {
        PANIssuerLogoContainer.image = nil
        PANIssuerLogoContainer.frame = CGRect(x: 0, y: 0, width: 0, height: PANIssuerLogoContainerUI.issuerContainerHeight)
            UIImageView().getRemoteImage(imageUrl: url) {  issuerLogoImage in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.setImage(issuerLogoImage, inImageView: self.PANIssuerLogoContainer)
                    self.setIssuerLogoConstraints()
                }
            }
        }

    private func setImage(_ tImage: UIImage, inImageView: UIImageView) {
        inImageView.image = UIImage.scale(image: tImage, by: inImageView.bounds.size.height/tImage.size.height)
    }
    
    private func setIssuerLogoConstraints() {
        PANContainer.addSubview(PANIssuerLogoContainer)
        
        NSLayoutConstraint.activate([
            PANIssuerLogoContainer.topAnchor.constraint(equalTo: PANContainer.topAnchor, constant: PANIssuerLogoContainerUI.topPadding),
            PANIssuerLogoContainer.bottomAnchor.constraint(equalTo: PANContainer.bottomAnchor, constant: PANIssuerLogoContainerUI.bottomPadding),
            PANIssuerLogoContainer.leadingAnchor.constraint(equalTo: PANContainer.leadingAnchor, constant: PANIssuerLogoContainerUI.leadingPadding)
        ])
        
        let issuerLogoContainerTrailingAnchor = PANIssuerLogoContainer.trailingAnchor.constraint(equalTo: PANContainer.trailingAnchor, constant: PANIssuerLogoContainerUI.trailingPadding)
        let issuerLogoContainerTrailingAnchorWithLabel = PANIssuerLogoContainer.trailingAnchor.constraint(equalTo: PANLabel.leadingAnchor, constant: PANIssuerLogoContainerUI.trailingPaddingWithLabel)
        
        if PANLabel.text != nil {
            issuerLogoContainerTrailingAnchorWithLabel.isActive = true
        } else { issuerLogoContainerTrailingAnchor.isActive = true }
    }
    
    private func setBackgroundColor(_ backgroundColor: String) {
        PANContainer.backgroundColor = UIColor.fromHex(backgroundColor)
    }
    
    private func setTextColor(_ textColor: String) {
        PANLabel.textColor = UIColor.fromHex(textColor)
    }
    
    private func setWeight(_ weight: String) {
        PANLabel.font = weight.getFont(size: PANLabelUI.labelFontSize)
    }
    
    public func setDisabledStyle() {
        PANContainer.backgroundColor = PANContainerUI.containerDisabledColor
        PANLabel.textColor = PANLabelUI.labelDisabledTextColor
    }
    
    //MARK: Observer
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        guard let change = change, let new = change[.newKey] else { return }

        isHidden = false
        setNumber(PANLabelUI.labelPlaceHolder)
        var numberLength = cardUI?.cardPattern.reduce(0, +)
        var panStartingPoint = (numberLength ?? 0) - PANLabelUI.labelLength

        if let changed = new as? String,
           let numberLength = numberLength,
           changed.count > panStartingPoint,
           panStartingPoint > 0 {

            var numberOfCharactersChanged = changed.count
            var lastCharacterChanged = String(changed.suffix(1))
            var panSuffix = numberOfCharactersChanged - panStartingPoint

            guard panSuffix >= 0 else { return }
            var panNumber = String(changed.suffix(panSuffix))
                .replacingFirstOccurrence(of: "•", with: lastCharacterChanged)
                .padding(toLength: PANLabelUI.labelLength, withPad: "•", startingAt: 0)
            
            if changed.count > 4 {
            panNumber.insert(" ", at: changed.index(changed.startIndex, offsetBy: 4))
            }
            setNumber(panNumber)
        }
    }
}

