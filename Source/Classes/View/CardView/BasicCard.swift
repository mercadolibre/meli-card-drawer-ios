//
//  BasicCard.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 05/05/21.
//

import Foundation

@objc protocol CardViewCustomViewProtocol {
    @objc optional func removeCustomView()
    @objc optional func addCustomView(_ customView: UIView)
}

@objc protocol CardViewInteractProtocol {
    @objc func setupAnimated(_ cardUI: CardUI)
    
    @objc optional func showSecurityCode()
}

protocol BasicCard: UIView, CardViewInteractProtocol, CardViewCustomViewProtocol {
    func setup(_ cardUI: CardUI, _ model: CardData, _ frame: CGRect, _ isDisabled: Bool, customLabelFontName: String?)
    func setupUI(_ cardUI: CardUI)
    func isShineEnabled() -> Bool
    func addShineView()
    func removeShineView()
    func removeGradient()
    func addGradient()
}
