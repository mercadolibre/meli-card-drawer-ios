import Foundation
import UIKit

protocol Font {
    var color: UIColor { get }
    var shadow: Bool { get }
    var gradient: Gradient { get }
}

class FontFactory {
    class func font(_ cardUI: CardUI, shadow: Bool = false) -> Font? {

        guard let fontType = cardUI.fontType else {
            return Default(cardUI.cardFontColor)
        }

        switch fontType {
        case "light":
            return Light(shadow: shadow)
        case "dark":
            return Dark(shadow: shadow)
        default:
            return Default(cardUI.cardFontColor)
        }
    }
}

struct Default: Font {
    var color: UIColor
    var shadow: Bool
    var gradient: Gradient    

    init(_ color: UIColor) {
        self.color = color
        shadow = false
        gradient = Gradient(color)
    }
}

struct Light: Font {
    var color: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    var gradient: Gradient = Gradient(top: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1),
                                      bottom: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
    var shadow: Bool

    init(shadow: Bool) {
        self.shadow = shadow
    }
}

struct Dark: Font {
    var color: UIColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
    var gradient: Gradient = Gradient(top: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8),
                                      bottom: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8))
    var shadow: Bool

    init(shadow: Bool) {
        self.shadow = shadow
    }
}
