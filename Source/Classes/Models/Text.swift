//
//  Text.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct Text: Codable {
    var textColor: String?
    let backgroundColor: String?
    var message: String?
    var weight: String?
    var defaultTextColor: UIColor = .clear
    var defaultBackgroundColor: UIColor = .clear
    
    enum CodingKeys: String, CodingKey {
        case textColor = "text_color"
        case backgroundColor = "background_color"
        case message
        case weight
    }
    
    public init(message: String?, textColor: String?, weight: String?, backgroundColor: String?) {
        self.message = message
        self.textColor = textColor
        self.weight = weight
        self.backgroundColor = backgroundColor
    }
    
    public init(message: String, textColor: String, weight: String) {
        self.message = message
        self.textColor = textColor
        self.weight = weight
        self.backgroundColor = nil
    }
    
    private struct PXTextWeight {
       static let regular: String = "regular"
       static let semiBold: String = "semi_bold"
       static let light: String = "light"
       static let bold: String = "bold"
   }
    
    func getTextColor() -> UIColor {
        guard let color = self.textColor else {
            return defaultTextColor
        }
        return UIColor.fromHex(color)
    }
    
    public func getBackgroundColor() -> UIColor {
        guard let color = self.backgroundColor else {
            return defaultBackgroundColor
        }
        return UIColor.fromHex(color)
    }
    
    func getFont(size: CGFloat = 14) -> UIFont {
        switch weight {
        case PXTextWeight.regular:
            return UIFont.systemFont(ofSize: size, weight: .regular)
        case PXTextWeight.semiBold:
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        case PXTextWeight.light:
            return UIFont.systemFont(ofSize: size, weight: .light)
        case PXTextWeight.bold:
            return UIFont.systemFont(ofSize: size, weight: .bold)
        default:
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
}
