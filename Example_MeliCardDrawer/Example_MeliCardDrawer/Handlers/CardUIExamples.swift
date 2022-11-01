import UIKit
import MLCardDrawer

struct CardUIExamples {
    
    static let cardUILists: [CardUI] = [
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
        var showChevron: Bool = true
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
        var cardPattern = [0, 0, 24, 4]
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
    
    class Pix: NSObject, GenericCardUI {
        var cardPattern = [4, 4, 4, 4]
        var placeholderName = ""
        var placeholderExpiration = ""
        var cardFontColor: UIColor = .white
        var defaultUI = false
        var securityCodePattern = 0
        var labelName = "NOVO"
        var labelTextColor = "#8DC0B6"
        var labelBackgroundColor = "#1A479AD1"
        var labelWeight = "bold"
        var titleName = "PIX"
        var titleTextColor = "#FFFFFF"
        var titleWeight = "bold"
        var subtitleName = "Aprovação Imediata"
        var subtitleTextColor = "#8DC0B6"
        var subtitleWeight = "regular"
        var securityCodeLocation = MLCardSecurityCodeLocation.none
        var cardBackgroundColor = UIColor.white
        var logoImageURL = "https://mobile.mercadolibre.com/remote_resources/image/card_drawer_mlb_pm_pix_normal?density=xhdpi&locale=pt_BR&version=1"
        var gradientColors = [""]
    }
    
    class Debin: NSObject, GenericCardUI {
        var cardPattern = [4, 4, 4, 4]
        var placeholderName = ""
        var placeholderExpiration = ""
        var cardFontColor: UIColor = .white
        var defaultUI = false
        var securityCodePattern = 0
        var labelName = "NUEVO"
        var labelTextColor = "#8DC0B6"
        var labelBackgroundColor = "#FFFFFF"
        var labelWeight = "bold"
        var titleName = "Banco BBVA"
        var titleTextColor = "#FFFFFF"
        var titleWeight = "bold"
        var subtitleName = "Apodo cuenta"
        var subtitleTextColor = "#FFFFFF"
        var subtitleWeight = "regular"
        var securityCodeLocation = MLCardSecurityCodeLocation.none
        var cardBackgroundColor = UIColor.white
        var logoImageURL = "https://http2.mlstatic.com/storage/logos-api-admin/227062e0-ae66-11eb-9123-2107040a9cba-xl@2x.png"
        var descriptionName = "CBU: ****333"
        var descriptionTextColor = "#FFFFFF"
        var descriptionWeight = "regular"
        var gradientColors = ["#002444", "#004580", "##0067BE"]
    }
    
    class Nubank: NSObject, PaymentMethodInfoCardUI {
        var entity: CustomText = CustomText(
            message: "Nubank",
            backgroundColor: nil,
            textColor: nil,
            weight: nil,
            alignment: nil
        )
        
        var amount: CustomText = CustomText(
            message: "1x R$ 10",
            backgroundColor: nil,
            textColor: nil,
            weight: nil,
            alignment: nil
        )
        
        var paymentType: CustomText = CustomText(
            message: "Crédito",
            backgroundColor: nil,
            textColor: nil,
            weight: nil,
            alignment: nil
        )
        
        var panStyle: CustomPAN? = CustomPAN(
            message: nil,
            issuerLogoUrl: "https://mobile.mercadolibre.com/remote_resources/image/card_drawer_mla_pm_master_white?density/dxxxhdpi/locale/es_AR",
            backgroundColor: nil,
            textColor: nil,
            weight: nil)
        
        var placeholderName = ""
        var placeholderExpiration = ""
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .white
        var cardBackgroundColor: UIColor = UIColor(red: 0.3529, green: 0.4588, blue: 0.5373, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
    }
    
    class AccountMoney: NSObject, PaymentMethodInfoCardUI {
        var entity: CustomText = CustomText(
            message: "Dinero en Cuenta",
            backgroundColor: nil,
            textColor: .white,
            weight: nil,
            alignment: nil
        )
        
        var panStyle: CustomPAN? = CustomPAN(
            message: nil,
            issuerLogoUrl: "https://mobile.mercadolibre.com/remote_resources/image/card_drawer_pm_AM?density/dxxxhdpi/locale/es_AR/version/d1",
            backgroundColor: nil,
            textColor: nil,
            weight: nil)
        
        var amount: CustomText = CustomText(
            message: "$40",
            backgroundColor: nil,
            textColor: .white,
            weight: nil,
            alignment: nil
        )
        
        var paymentType: CustomText = CustomText(
            message: nil,
            backgroundColor: nil,
            textColor: .white,
            weight: nil,
            alignment: nil
        )
        
        var overlay = UIImage(named: "amPattern")
        var gradient: CAGradientLayer? = {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor(red: 0.67, green: 1, blue: 1, alpha: 1).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 0)
            return gradient
        }()
        
        var placeholderName = ""
        var placeholderExpiration = ""
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .white
        var cardBackgroundColor: UIColor = UIColor(red: 0, green: 0.62, blue: 0.886, alpha: 1.0)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
    }
    
    class GaliciaYellowCard: NSObject, PaymentMethodInfoCardUI {
        var entity: CustomText = CustomText(
            message: "Banco Galicia",
            backgroundColor: nil,
            textColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.9),
            weight: nil,
            alignment: nil
        )
        
        var amount: CustomText = CustomText(
            message: "3x $ 10",
            backgroundColor: nil,
            textColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.9),
            weight: nil,
            alignment: nil
        )
        
        var paymentType: CustomText = CustomText(
            message: "Crédito",
            backgroundColor: nil,
            textColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.9),
            weight: nil,
            alignment: nil
        )
        
        var placeholderName = ""
        var placeholderExpiration = ""
        var cardPattern = [4, 4, 4, 4]
        var cardFontColor: UIColor = .white
        var cardBackgroundColor: UIColor = UIColor(red: 1, green: 0.902, blue: 0, alpha: 1)
        var securityCodeLocation: MLCardSecurityCodeLocation = .back
        var defaultUI = false
        var securityCodePattern = 3
    }
}
