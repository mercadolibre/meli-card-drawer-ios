import Foundation
import UIKit

@objc public enum MLCardSecurityCodeLocation: Int {
    case front, back, none
}

@objc public protocol CardUI {
    var cardPattern: [Int] { get set }
    var cardBackgroundColor: UIColor { get }
    var securityCodeLocation: MLCardSecurityCodeLocation { get }
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
    
    @objc optional func set(logo: UIImageView)
    @objc optional var fontType: String { get }
    @objc optional var fullCardArt: String { get }
    @objc optional var PAN: CustomPAN { get }
}

@objc public protocol CustomCardDrawerUI: CardUI {
    @objc optional var ownGradient: CAGradientLayer { get }
}

@objc public class CustomPAN: NSObject {
    var backgroundColor: String?
    var fontColor: String?
    var weight: String?
    
    public init(
        backgroundColor: String?,
        fontColor: String?,
        weight: String?
    ) {
        self.backgroundColor = backgroundColor
        self.fontColor = fontColor
        self.weight = weight
    }
}
