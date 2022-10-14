import Foundation

@objc public protocol PaymentMethodInfoCardUI: CardUI {
    @objc optional var entity: CustomText { get }
    @objc optional var amount: CustomText { get }
    @objc optional var paymentType: CustomText { get }
    @objc optional var gradient: CAGradientLayer { get }
    @objc optional var overlay: UIImage? { get }
}

@objc public class CustomText: NSObject {
    public var message: String?
    public var backgroundColor: UIColor?
    public var textColor: UIColor?
    public var weight: String?
    public var alignment: NSTextAlignment?
    
    public init(
        message: String?,
        backgroundColor: UIColor?,
        textColor: UIColor?,
        weight: String?,
        alignment: NSTextAlignment?
    ) {
        self.message = message
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.weight = weight
        self.alignment = alignment
    }
}
