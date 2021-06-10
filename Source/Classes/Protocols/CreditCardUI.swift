//
//  CreditCardUI.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 04/05/21.
//

import Foundation

@objc public protocol CreditCardUI: CardUI {
    var cardPattern: [Int] { get set }
    var placeholderName: String { get }
    var placeholderExpiration: String { get }
    var cardFontColor: UIColor { get }
    var defaultUI: Bool { get }
    var securityCodePattern: Int { get }

    @objc optional func set(bank: UIImageView)
    @objc optional var bankImage: UIImage? { get }
    @objc optional var cardLogoImage: UIImage? { get }
    @objc optional var debitImage: UIImage? { get }
    @objc optional var showChevron: Bool { get }

    @objc optional var ownOverlayImage: UIImage? { get }

    @objc optional var cardLogoImageUrl: String? { get }
    @objc optional var bankImageUrl: String? { get }
}


@objc public protocol CustomCardDrawerUI: CreditCardUI {
    @objc optional var ownGradient: CAGradientLayer { get }
}
