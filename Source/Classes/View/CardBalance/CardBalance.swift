//
//  CardBalance.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 13/06/22.
//

import UIKit

public class CardBalance: UIView {
    private let imageName: String = "eye"
    private let titleFontSize: CGFloat = 12.0
    private let balanceFontSize: CGFloat = 14.0
    private let constrainButton: CGFloat = 6
    private let constrainBalance: CGFloat = 2
    
    private var eyeButton: UIButton!
    public var model: CardBalanceModel?
    public var delegate: CardBalanceDelegate?

    private let balanceTitle: UILabel! = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    private let balanceLabel: UILabel! = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    public var showBalance: Bool = false {
        didSet{
            setBalanceLabel()
        }
    }
    private func setBalanceLabel (){
        guard let balance = model?.balance, let hiddenBalance = model?.hiddenBalance else {
            return
        }
        if (showBalance) {
            balanceLabel.text = balance.message
            setupLabelColors(balanceLabel, field: balance)
        } else {
            balanceLabel.text = hiddenBalance.message
            setupLabelColors(balanceLabel, field: hiddenBalance)
        }
        balanceLabel.sizeToFit()
    }
    
    public init(model: CardBalanceModel, showBalance: Bool) {
        self.model = model
        self.showBalance = showBalance
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        model = nil
        super.init(coder: coder)
    }
    
    public func render() {
        setBalanceLabel()
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        guard let model = model else {
            return
        }
        
        balanceTitle.font = UIFont.systemFont(ofSize: titleFontSize, weight: .regular)
        balanceTitle.text = model.title.message
        
        balanceLabel.font = UIFont.systemFont(ofSize: balanceFontSize, weight: .semibold)
        
        eyeButton = UIButton()
        eyeButton.setImage(UIImage(named: imageName, in: MLCardDrawerBundle.bundle(), compatibleWith: nil), for: .normal)
        eyeButton.backgroundColor = .clear
        eyeButton.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
        
        balanceLabel.sizeToFit()
        balanceTitle.sizeToFit()
        eyeButton.sizeToFit()
        
        setupLabelColors(balanceTitle, field: model.title)

        self.addSubview(balanceTitle)
        self.addSubview(balanceLabel)
        self.addSubview(eyeButton)
    }
    
    @objc private func buttonAction(sender: UIButton){
        guard let delegate = delegate else {
            return
        }
        showBalance = delegate.toggleBalance()
    }
    
    private func setupConstraints() {
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceTitle.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            balanceTitle.topAnchor.constraint(equalTo: self.topAnchor),
            balanceTitle.rightAnchor.constraint(equalTo: self.rightAnchor),
            eyeButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            eyeButton.leftAnchor.constraint(equalTo: balanceLabel.rightAnchor, constant: constrainButton),
            balanceLabel.topAnchor.constraint(equalTo: balanceTitle.bottomAnchor, constant: constrainBalance),
            eyeButton.centerYAnchor.constraint(equalTo: balanceLabel.centerYAnchor)
            
        ])
    }
    
    private func setupLabelColors(_ label: UILabel, field: Text) {
        if let textColor = field.textColor {
            label.textColor = UIColor.fromHex(textColor)
        }
        if let backgroundColor = field.backgroundColor {
            label.backgroundColor = UIColor.fromHex(backgroundColor)
        }
    }
    
}
