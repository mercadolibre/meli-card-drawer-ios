import UIKit
import MLCardDrawer

struct CardUIExamples {
    
    static let cardUILists: [CardUI] = [
        CardUIExamples.SafeArea(),
        CardUIExamples.AmericanExpress(),
        CardUIExamples.Visa(),
        CardUIExamples.Maestro19(),
        CardUIExamples.GaliciaAmex(),
        CardUIExamples.VisaSantander(),
        CardUIExamples.Maestro18(),
        CardUIExamples.Visa(),
        CardUIExamples.Visa1(),
        CardUIExamples.Visa2(),
        CardUIExamples.Visa3(),
        CardUIExamples.Visa4(),
        CardUIExamples.Visa5(),
        CardUIExamples.PatagoniaRemoteImages(),
        CardUIExamples.VisaRemoteImages()
    ]
    
    
    // codebeat:disable[TOO_MANY_IVARS]
    
    // Example - Default CardUI
    class CardDefaultUI: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        var cardLogoImage: UIImage?
        var cardBackgroundColor: UIColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = true
        var securityCodePattern = 3
    }
    
    // Example - SafeArea
    class SafeArea: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [4, 4]
        var cardFontColor: UIColor = .white
        var cardLogoImage: UIImage? = UIImage(named: "visa")
        var cardBackgroundColor: UIColor = UIColor(red: 135/255, green: 171/255, blue: 158/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
    }

    // Example - American Express
    class AmericanExpress: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [4, 6, 4]
        var cardFontColor: UIColor = .white
        var cardLogoImage: UIImage? = UIImage(named: "amex")
        var cardBackgroundColor: UIColor = UIColor(red: 135/255, green: 171/255, blue: 158/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .front
        var defaultUI = false
        var securityCodePattern = 4
        var fontType: String = "light"
    }

    // Example - Visa
    class Visa: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .white
        var cardLogoImage: UIImage? = UIImage(named: "visa")
        var cardBackgroundColor: UIColor = UIColor(red: 37/255, green: 97/255, blue: 192/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
    }

    // Example - Maestro (18)
    class Maestro18: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [10, 5, 3]
        var cardFontColor: UIColor = .white
        var cardLogoImage: UIImage? = UIImage(named: "debmaestro")
        var cardBackgroundColor: UIColor = UIColor(red: 90/255, green: 117/255, blue: 137/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
    }

    // Example - Maestro (19)
    class Maestro19: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [9, 10]
        var cardFontColor: UIColor = .white
        var cardLogoImage: UIImage? = UIImage(named: "debmaestro")
        var cardBackgroundColor: UIColor = UIColor(red: 90/255, green: 117/255, blue: 137/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
    }

    // Example - Galicia Amex
    class GaliciaAmex: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage? = UIImage(named: "galicia")
        var cardPattern = [5, 6, 5]
        var cardFontColor: UIColor = .white
        var cardLogoImage: UIImage? = UIImage(named: "amex")
        var cardBackgroundColor: UIColor = UIColor(red: 247/255, green: 149/255, blue: 52/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .front
        var defaultUI = false
        var securityCodePattern = 4
        var fontType: String = "light"
    }

    // Example - Visa 1
    class Visa1: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .white
        var cardLogoImage: UIImage? = UIImage(named: "visa")
        var cardBackgroundColor: UIColor = UIColor(red: 72/255, green: 150/255, blue: 178/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
    }

    // Example - Visa 2
    class Visa2: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .white
        var cardLogoImage: UIImage? = UIImage(named: "visa")
        var cardBackgroundColor: UIColor = UIColor(red: 86/255, green: 151/255, blue: 54/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
    }

    // Example - Visa 3
    class Visa3: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .white
        var cardLogoImage: UIImage? = UIImage(named: "visa")
        var cardBackgroundColor: UIColor = UIColor(red: 184/255, green: 157/255, blue: 94/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
    }

    // Example - Visa 4
    class Visa4: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .darkGray
        var cardLogoImage: UIImage? = UIImage(named: "visa")
        var cardBackgroundColor: UIColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
    }

    // Example - Visa 5
    class Visa5: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .darkGray
        var cardLogoImage: UIImage? = UIImage(named: "visa")
        var cardBackgroundColor: UIColor = UIColor(red: 255/255, green: 223/255, blue: 10/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "dark"
    }

    // Example - Visa 6
    class VisaSantander: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var bankImage: UIImage?
        var cardPattern = [0, 0, 3, 4]
        var cardFontColor: UIColor = .white
        var cardLogoImage: UIImage? = UIImage(named: "visaLight")
        var cardBackgroundColor: UIColor = UIColor(red: 213/255, green: 56/255, blue: 56/255, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
        var debitImageUrl: String? = "https://mobile.mercadolibre.com/remote_resources/image/buflo_payment_card_visa-debito-white?density=xxhdpi&locale=es_AR"
    }

    // Example - Visa 6
    class VisaRemoteImages: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .white
        var cardBackgroundColor: UIColor = #colorLiteral(red: 0.02923904359, green: 0.08856200427, blue: 0.0886611715, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
        var cardLogoImageUrl: String? = "https://mobile.mercadolibre.com/remote_resources/image/buflo_payment_card_visa-debito-white?density=xxhdpi&locale=es_AR"
        var bankImageUrl: String? = "https://mobile.mercadolibre.com/remote_resources/image/buflo_payment_card_naranja?density=xxhdpi&locale=es_AR"
    }

    class PatagoniaRemoteImages: NSObject, CardUI {
        var placeholderName = "NOMBRE Y APELLIDO"
        var placeholderExpiration = "MM/AA"
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .white
        var cardBackgroundColor: UIColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
        var fontType: String = "light"
        var cardLogoImageUrl: String? = "https://mobile.mercadolibre.com/remote_resources/image/buflo_payment_card_banco-patagonia?density=xxhdpi&locale=es_AR"
        var bankImageUrl: String? = "https://mobile.mercadolibre.com/remote_resources/image/buflo_payment_card_banco-frances?density=xxhdpi&locale=es_AR"
    }
    
    // codebeat:enable[TOO_MANY_IVARS]
}
