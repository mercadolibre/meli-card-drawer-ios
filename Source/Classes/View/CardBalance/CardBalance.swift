//
//  CardBalance.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 13/06/22.
//

import UIKit

public class CardBalance: UIView {
    
    private var eyeButton: UIButton!
    private var model: CardBalanceModel

    private let balanceTitle: UILabel! = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    private let balance: UILabel! = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    private var showBalance: Bool{
        didSet{
            if (showBalance) {
                balance.text = model.balance.message
                setupLabelColors(balance, field: model.balance)
            } else {
                balance.text = model.hiddenBalance.message
                setupLabelColors(balance, field: model.hiddenBalance)
            }
        }
    }
    
    init(model: CardBalanceModel, showBalance: Bool = true) {
        self.model = model
        self.showBalance = showBalance
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        balanceTitle.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        balanceTitle.text = model.title.message
        
        balance.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        balance.backgroundColor = UIColor.clear
        
        eyeButton.setImage(UIImage.init(named: "eye"), for: .normal)
        eyeButton.backgroundColor = .clear
        eyeButton.addTarget(self, action: #selector(self.toggleBalance(sender:)), for: .touchUpInside)
        
        setupLabelColors(balanceTitle, field: model.title)
    }
    
    private func setupConstraints() {
        balanceTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        balance.topAnchor.constraint(equalTo: balanceTitle.bottomAnchor, constant: 2)
        balance.rightAnchor.constraint(equalTo: self.rightAnchor)
        balanceTitle.rightAnchor.constraint(equalTo: self.rightAnchor)
        eyeButton.leftAnchor.constraint(equalTo: balance.rightAnchor)
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
