import Foundation
import UIKit

@objc public enum MLCardSecurityCodeLocation: Int {
    case front, back, none
}

@objc public protocol CardUI {
    var cardPattern: [Int] { get set }
    var cardBackgroundColor: UIColor { get }
    var securityCodeLocation: MLCardSecurityCodeLocation { get }
    
    @objc optional func set(logo: UIImageView)
    @objc optional var fontType: String { get }
}

