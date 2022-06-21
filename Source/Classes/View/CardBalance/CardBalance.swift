//
//  CardBalance.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 13/06/22.
//

import UIKit

public class CardBalance: UIView {
    
    @IBOutlet weak var balanceTitle: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var coin: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    
    private var showBalance: Bool{
        didSet{
            balance.text = showBalance ? model.balance.message : hideBalanceString
        }
    }
    private var model: CardBalanceModel
    
    private let defaultTextColor = "#FFFFFF"
    private let hideBalanceString = "..."
    
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
        balanceTitle.text = model.balance.message
        balanceTitle.textColor = UIColor.fromHex(model.balanceTitle.textColor ?? defaultTextColor)
        balanceTitle.backgroundColor = UIColor.clear
        
        balance.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        balance.textColor = UIColor.fromHex(model.balance.textColor ?? defaultTextColor)
        balance.backgroundColor = UIColor.clear
        
        coin.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        coin.text = model.coin.message
        coin.textColor = UIColor.fromHex(model.coin.textColor ?? defaultTextColor)
        coin.backgroundColor = UIColor.clear
        eyeButton.setImage(UIImage.init(named: "eye"), for: .normal)
        eyeButton.addTarget(self, action: #selector(self.toggleBalance(sender:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        balanceTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        balance.topAnchor.constraint(equalTo: balanceTitle.bottomAnchor, constant: 2)
        balance.rightAnchor.constraint(equalTo: self.rightAnchor)
        balanceTitle.rightAnchor.constraint(equalTo: self.rightAnchor)
        coin.rightAnchor.constraint(equalTo: balance.leftAnchor)
        balanceTitle.leftAnchor.constraint(equalTo: coin.leftAnchor)
        eyeButton.leftAnchor.constraint(equalTo: balance.rightAnchor)
    }
    
    @objc public func toggleBalance(sender: UIButton){
        showBalance = !showBalance
    }
}
