//
//  CardBalance.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 13/06/22.
//

import UIKit

public class CardBalance: UIView {
    
    private var eyeButton: UIButton!
    private let model: CardBalanceModel?

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
    
    private var showBalance: Bool = false {
        didSet{
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
        }
    }
    
    public init(model: CardBalanceModel, showBalance: Bool) {
        self.model = model
        self.showBalance = showBalance
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        model = nil
        super.init(coder: coder)
    }
    
    private func setupUI() {
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        guard let model = model else {
            return
        }
        
        balanceTitle.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        balanceTitle.text = model.title.message
        
        balanceLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        balanceLabel.backgroundColor = UIColor.clear
        
        eyeButton.setImage(UIImage.init(named: "eye", in: MLCardDrawerBundle.bundle(), compatibleWith: nil), for: .normal)
        eyeButton.backgroundColor = .clear
        eyeButton.addTarget(self, action: #selector(self.toggleBalance(sender:)), for: .touchUpInside)
        
        setupLabelColors(balanceTitle, field: model.title)
    }
    
    private func setupConstraints() {
        balanceTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        balanceLabel.topAnchor.constraint(equalTo: balanceTitle.bottomAnchor, constant: 2)
        balanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        balanceTitle.rightAnchor.constraint(equalTo: self.rightAnchor)
        eyeButton.leftAnchor.constraint(equalTo: balanceLabel.rightAnchor)
    }
    
    @objc public func toggleBalance(sender: UIButton){
        showBalance = !showBalance
    }
    
    private func setupLabelColors(_ label: UILabel, field: CardBalanceText) {
        if let textColor = field.textColor {
            label.textColor = UIColor.fromHex(textColor)
        }
        if let backgroundColor = field.backgroundColor {
            label.backgroundColor = UIColor.fromHex(backgroundColor)
        }
    }
    
}
