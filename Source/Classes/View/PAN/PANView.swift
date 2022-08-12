import UIKit

class PANView: UIView {
    
    private let labelTextColor: UIColor = .white
    private let labelBackgroundColor: UIColor = .clear
    private let labelFontSize: CGFloat = 14.0
    private let labelPlaceholder: String = "•••• ••••"
    private let containerBackgroundColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
    private let containerCornerRadius: CGFloat = 4.0
    private let topPadding: CGFloat = 4.0
    private let bottomPadding: CGFloat = -4.0
    private let leftPadding: CGFloat = 8.0
    private let rightPadding: CGFloat = -8.0

    private var PANLabel: UILabel!
    private var PANContainer: UIView!
    
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
        PANLabel.font = UIFont.systemFont(ofSize: labelFontSize, weight: .semibold)
        PANLabel.text = labelPlaceholder
        PANLabel.backgroundColor = labelBackgroundColor
        PANLabel.textColor = labelTextColor
        PANLabel.clipsToBounds = true
        PANLabel.sizeToFit()
    }
    
    private func setupContainer() {
        PANContainer = UIView()
        PANContainer.backgroundColor = containerBackgroundColor
        PANContainer.layer.cornerRadius = containerCornerRadius
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
            PANLabel.topAnchor.constraint(equalTo: PANContainer.topAnchor, constant: topPadding),
            PANLabel.bottomAnchor.constraint(equalTo: PANContainer.bottomAnchor, constant: bottomPadding),
            PANLabel.rightAnchor.constraint(equalTo: PANContainer.rightAnchor, constant: rightPadding),
            PANLabel.leftAnchor.constraint(equalTo: PANContainer.leftAnchor, constant: leftPadding)
        ])
    }
}

extension PANView {
            
    public func setNumber(_ number: String) {
        PANLabel.text = "•••• " + number
    }
    
    public func setPANStyle(_ cardUI: CardUI) {

        if let backgroundColor = cardUI.PANBackgroundColor {
            setBackgroundColor(backgroundColor)
        }
        
        if let textColor = cardUI.PANTextColor {
            setTextColor(textColor)
        }
        
        if let textWeight = cardUI.PANTextWeight {
            setTextWeight(textWeight)
        }
    }
    
    private func setBackgroundColor(_ backgroundColor: String) {
        PANContainer.backgroundColor = UIColor.fromHex(backgroundColor)
    }
    
    private func setTextColor(_ textColor: String) {
        PANLabel.textColor = UIColor.fromHex(textColor)
    }
    
    private func setTextWeight(_ textWeight: String) {
        PANLabel.font = textWeight.getFont(size: labelFontSize)
    }
}
