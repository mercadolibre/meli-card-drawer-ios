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
    
    var PANLabel: UILabel!
    var PANContainer: UIView!
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
    }
    
    private func setupContainer() {
        PANContainer = UIView()
        PANContainer.backgroundColor = PANContainerUI.containerBackgroundColor
        PANContainer.layer.cornerRadius = PANContainerUI.containerCornerRadius
        PANContainer.clipsToBounds = true
        PANContainer.sizeToFit()
    }
    
    private func setupConstraints() {
        self.addSubview(PANContainer)
        PANContainer.addSubview(PANLabel)
        
        PANLabel.translatesAutoresizingMaskIntoConstraints = false
        PANContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            PANContainer.topAnchor.constraint(equalTo: self.topAnchor),
            PANContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            PANContainer.rightAnchor.constraint(equalTo: self.rightAnchor),
            PANContainer.leftAnchor.constraint(equalTo: self.leftAnchor),
            PANLabel.topAnchor.constraint(equalTo: PANContainer.topAnchor, constant: PANLabelUI.topPadding),
            PANLabel.bottomAnchor.constraint(equalTo: PANContainer.bottomAnchor, constant: PANLabelUI.bottomPadding),
            PANLabel.rightAnchor.constraint(equalTo: PANContainer.rightAnchor, constant: PANLabelUI.rightPadding),
            PANLabel.leftAnchor.constraint(equalTo: PANContainer.leftAnchor, constant: PANLabelUI.leftPadding)
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
        
        if let pan = cardUI.pan {
            if let message = pan?.message {
                setNumber(message)
            }
            
            if let backgroundColor = pan?.backgroundColor {
                setBackgroundColor(backgroundColor)
            }
            
            if let textColor = pan?.textColor {
                setTextColor(textColor)
            }
            
            if let weight = pan?.weight {
                setWeight(weight)
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
        var numberLengthWithoutPan = (numberLength ?? 0)  - PANLabelUI.labelLength

        if let changed = new as? String,
           let numberLength = numberLength,
           changed.count > numberLengthWithoutPan,
           numberLengthWithoutPan > 0 {

            var numberOfCharactersChanged = changed.count
            var lastCharacterChanged = String(changed.suffix(1))
            var panStartingPoint = Int((Double(numberLength)/2).rounded(.down))
            var panSuffix = numberOfCharactersChanged - panStartingPoint

            guard panSuffix >= 0 else { return }
            var panNumber = String(changed.suffix(panSuffix))
                .replacingFirstOccurrence(of: "•", with: lastCharacterChanged)
                .padding(toLength: PANLabelUI.labelLength, withPad: "•", startingAt: 0)
            panNumber.insert(" ", at: changed.index(changed.startIndex, offsetBy: 4))

            setNumber(panNumber)
        }
    }
}

