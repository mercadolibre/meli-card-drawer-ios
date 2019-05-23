//
//  TestMock.swift
//  Example_MeliCardDrawerTests
//
//  Created by Juan sebastian Sanzone on 5/22/19.
//  Copyright © 2019 Mercadolibre. All rights reserved.
//

import UIKit
@testable import Example_MeliCardDrawer
@testable import MeliCardDrawer

class CardDataMock: NSObject, CardData {
    var name = ""
    var number = ""
    var expiration = ""
    var securityCode = ""
}

class CardUIMock: NSObject, CardUI {
    var placeholderName = "NOMBRE Y APELLIDO"
    var placeholderExpiration = "MM/AA"
    var cardPattern = [4, 4, 4]
    var bankImage: UIImage? = nil
    var cardFontColor: UIColor = .black
    var cardLogoImage: UIImage? = nil
    var cardBackgroundColor: UIColor = .cyan
    var securityCodeLocation: Location = .front
    var defaultUI: Bool = true
    var securityCodePattern = 3
}
