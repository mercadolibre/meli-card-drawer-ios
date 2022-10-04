//
//  CardBalance.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 13/06/22.
//

import UIKit

public class CardBalance: UIView {
    private var imageName: String = "eye"
    private let titleFontSize: CGFloat = 12.0
    private let balanceFontSize: CGFloat = 14.0
    private let constrainButton: CGFloat = 6
    private let constrainBalance: CGFloat = 2
    
    private var button: UIButton!
    private var eyeImage: UIImageView!
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
            imageName = "eye"
        } else {
            balanceLabel.text = hiddenBalance.message
            setupLabelColors(balanceLabel, field: hiddenBalance)
            imageName = "eye_closed"
        }
        balanceLabel.sizeToFit()
        if eyeImage != nil {
            eyeImage.image = UIImage(named: imageName, in: MLCardDrawerBundle.bundle(), compatibleWith: nil)
        }
        
        
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
        
        if model.title != nil {
            guard let title = model.title else { return }
            balanceTitle.font = UIFont.systemFont(ofSize: titleFontSize, weight: .regular)
            balanceTitle.text = title.message
            setupLabelColors(balanceTitle, field: title)
        } else {
            balanceTitle.text = ""
        }
        
        
        
        balanceLabel.font = UIFont.systemFont(ofSize: balanceFontSize, weight: .semibold)
        
        eyeImage = UIImageView()
        eyeImage.image = UIImage(named: imageName, in: MLCardDrawerBundle.bundle(), compatibleWith: nil)
        
        button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
        
        balanceLabel.sizeToFit()
        balanceTitle.sizeToFit()
        eyeImage.sizeToFit()

        self.addSubview(balanceTitle)
        self.addSubview(balanceLabel)
        self.addSubview(eyeImage)
        self.addSubview(button)
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
        eyeImage.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            balanceTitle.topAnchor.constraint(equalTo: self.topAnchor),
            balanceTitle.rightAnchor.constraint(equalTo: self.rightAnchor),
            eyeImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            eyeImage.leftAnchor.constraint(equalTo: balanceLabel.rightAnchor, constant: constrainButton),
            balanceLabel.topAnchor.constraint(equalTo: balanceTitle.bottomAnchor, constant: constrainBalance),
            eyeImage.centerYAnchor.constraint(equalTo: balanceLabel.centerYAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leftAnchor.constraint(equalTo: self.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.rightAnchor)
        
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

