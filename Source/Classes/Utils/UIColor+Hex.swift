//
//  UIColor+Hex.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 25/03/21.
//

extension UIColor {
    class func fromHex(_ hexValue: String) -> UIColor {
        let hexAlphabet = "0123456789abcdefABCDEF"
        let hex = hexValue.trimmingCharacters(in: CharacterSet(charactersIn: hexAlphabet).inverted)
        var hexInt = UInt32()
        Scanner(string: hex).scanHexInt32(&hexInt)
        let alpha, red, green, blue: UInt32
        switch hex.count {
        case 3: (alpha, red, green, blue) = (255, (hexInt >> 8) * 17, (hexInt >> 4 & 0xF) * 17, (hexInt & 0xF) * 17) // RGB
        case 6: (alpha, red, green, blue) = (255, hexInt >> 16, hexInt >> 8 & 0xFF, hexInt & 0xFF) // RRGGBB
        case 8: (alpha, red, green, blue) = (hexInt >> 24, hexInt >> 16 & 0xFF, hexInt >> 8 & 0xFF, hexInt & 0xFF) // AARRGGBB
        default: return UIColor.black
        }
        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha)/255)
    }
}
