import Foundation
import MLCardDrawer

// Example - CardDataHandler
@objc class CardDataHandler: NSObject, CardData {
    var name = "NOMBRE Y APELLIDO"
    var number = "1234567891234567"
    var securityCode = ""
    var expiration = "MM/AA"
}

@objc class CardDataHandler2: NSObject, CardData {
    var name = "NOMBRE Y APELLIDO"
    var number = "9012345678012390"
    var securityCode = ""
    var expiration = "MM/AA"
}

@objc class CardDataEmpty: NSObject, CardData {
    var name = ""
    var number = ""
    var securityCode = ""
    var expiration = ""
}
