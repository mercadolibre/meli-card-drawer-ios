import UIKit

class PANView: UIView {
    
    enum PANLabelUI {
        static let labelPlaceHolder = "•••• ••••"
        static let labelTextColor: UIColor = .white
        static let labelBackgroundColor: UIColor = .clear
        static let labelFontSize: CGFloat = 14.0
        static let topPadding: CGFloat = 4.0
        static let bottomPadding: CGFloat = -4.0
        static let leftPadding: CGFloat = 8.0
        static let rightPadding: CGFloat = -8.0
        static let labelDisabledTextColor: UIColor = .fromHex("#F0F0F0")
        static let labelLength = 8
    }
    
    enum PANContainerUI {
        static let containerBackgroundColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
        static let containerCornerRadius: CGFloat = 4.0
        static let containerDisabledColor: UIColor = .fromHex("#A0A0A0")
    }
    
    enum IssuerContainerUI {
        static let leftPadding: CGFloat = 8.0
        static let rightPadding: CGFloat = -4.0
        static let containerHeight: CGFloat = 15.0
    }
    
    var PANLabel: UILabel!
    var PANContainer: UIView!
    var PANIssuerContainer: UIImageView!
    var cardUI: CardUI?
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [PANIssuerContainer,PANLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4.0
        stackView.distribution = .fill
        return stackView
    }()
    
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
        setupIssuerContainer()
    }
    
    private func setupLabel() {
        PANLabel = UILabel()
        PANLabel.font = .proximaNovaSemibold(size: PANLabelUI.labelFontSize)
        PANLabel.backgroundColor = PANLabelUI.labelBackgroundColor
        PANLabel.textColor = PANLabelUI.labelTextColor
        PANLabel.text = PANLabelUI.labelPlaceHolder
        PANLabel.clipsToBounds = true
        PANLabel.sizeToFit()
    }
    
    private func setupContainer() {
        PANContainer = UIView()
        PANContainer.backgroundColor = PANContainerUI.containerBackgroundColor
        PANContainer.layer.cornerRadius = PANContainerUI.containerCornerRadius
        PANContainer.clipsToBounds = true
        PANContainer.sizeToFit()
    }
    
    private func setupIssuerContainer() {
        PANIssuerContainer = UIImageView()
        PANIssuerContainer.contentMode = .scaleAspectFill
        PANIssuerContainer.sizeToFit()
    }
    
    private func setupConstraints() {
        
        self.addSubview(PANContainer)
        PANContainer.addSubview(stackView)
        
        PANLabel.translatesAutoresizingMaskIntoConstraints = false
        PANContainer.translatesAutoresizingMaskIntoConstraints = false
        PANIssuerContainer.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            PANContainer.topAnchor.constraint(equalTo: self.topAnchor),
            PANContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            PANContainer.rightAnchor.constraint(equalTo: self.rightAnchor),
            PANContainer.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            stackView.topAnchor.constraint(equalTo: PANContainer.topAnchor, constant: PANLabelUI.topPadding),
            stackView.bottomAnchor.constraint(equalTo: PANContainer.bottomAnchor, constant: PANLabelUI.bottomPadding),
            stackView.rightAnchor.constraint(equalTo: PANContainer.rightAnchor, constant: PANLabelUI.rightPadding),
            stackView.leftAnchor.constraint(equalTo: PANContainer.leftAnchor, constant: PANLabelUI.leftPadding),
            
            PANIssuerContainer.centerYAnchor.constraint(equalTo: PANContainer.centerYAnchor),
            PANIssuerContainer.heightAnchor.constraint(equalToConstant: IssuerContainerUI.containerHeight),
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
            
            if let backgroundColor = panStyle?.backgroundColor {
                setBackgroundColor(backgroundColor)
            }
            
            if let textColor = panStyle?.textColor {
                setTextColor(textColor)
            }
            
            if let weight = panStyle?.weight {
                setWeight(weight)
            }
            
            if let issuerImage = panStyle?.issuerImage {
                setIssuerImage(issuerImage)
            } else {
                self.stackView.removeArrangedSubview(PANIssuerContainer)
                PANIssuerContainer.isHidden = true
            }
        }
        
        if disabled {
            setDisabledStyle()
        }
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
    
    func setIssuerImage(_ issuerImage: String) {
        setImage(from: issuerImage)
    }
    
    private func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.PANIssuerContainer.image = image
            }
        }
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

