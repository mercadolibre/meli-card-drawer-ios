import Foundation

@objc public protocol PaymentMethodInfoCardUI: CardUI {
    var topLeftContentText: String? { get }
    var topLeftContentTextColor: String? { get }
    var topLeftContentTextWeight: String? { get }
    var topLeftContentTextAlignment: String? { get }
    var topRightContentText: String? { get }
    var topRightContentTextColor: String? { get }
    var topRightContentTextWeight: String? { get }
    var topRightContentTextAlignment: String? { get }
    var bottomRightContentText: String? { get }
    var bottomRightContentTextColor: String? { get }
    var bottomRightContentTextWeight: String? { get }
    var bottomRightContentTextAlignment: String? { get }
}
