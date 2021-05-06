import Foundation
import UIKit

@objc public protocol CardUI {
    var cardBackgroundColor: UIColor { get }
    
    @objc optional func set(logo: UIImageView)
    @objc optional var fontType: String { get }
}

