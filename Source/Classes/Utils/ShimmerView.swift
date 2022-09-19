import Foundation

public class CardShimmer: UIView {
    
    let shimmerView = ShimmerView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func showCardShimmer() {
        self.layer.cornerRadius = 7.0
        shimmerView.backgroundColor = .fromHex("#E5E5E5")
        shimmerView.setGradientColor()
        shimmerView.layer.cornerRadius = 8.0
        shimmerView.clipsToBounds = true
        shimmerView.slide(direction: .right)
        
        addSubview(shimmerView)
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = self.superview {
            NSLayoutConstraint.activate([
                shimmerView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                shimmerView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                shimmerView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                shimmerView.topAnchor.constraint(equalTo: superview.topAnchor)
            ])
        }
    }
    
    func hideCardShimmer() {
        shimmerView.isHidden = true
    }
}

public class ShimmerView: UIView {

    private let brightened: CGFloat = 0.94
    public let gradientView = GradientView(frame: .zero)

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUpGradientView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpGradientView()
    }

    fileprivate func setUpGradientView() {
        gradientView.backgroundColor = UIColor.clear
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gradientView)

        let top = gradientView.topAnchor.constraint(equalTo: topAnchor)
        let bottom = gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let leading = gradientView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = gradientView.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }

    public func setGradientColor() {
        gradientView.layer.cornerRadius = self.layer.cornerRadius
        gradientView.layer.borderWidth = self.layer.borderWidth
        if let color = self.backgroundColor {
            self.gradientView.gradientLayer.colors = [color.cgColor, color.brightened(by: brightened).cgColor, color.cgColor]
        }
    }

    public func slide(direction: GradientDirection) {
        self.gradientView.gradientLayer.slide(direction: direction)
    }

    public func stopSliding() {
        self.gradientView.gradientLayer.stopSliding()
    }
}

/// A `Transition` between two `GradientPoint`s.
typealias GradientTransition = Transition<GradientPoint>

/// A generic structure to represent a transition.
struct Transition<T> {
    /// The beginning of the Transition.
    let from: T
    /// The end of the Transition.
    let to: T
}

infix operator -->: AdditionPrecedence
/// A custom operator that builds a `Transition<T>`
func --><T>(from: T, to: T) -> Transition<T> {
    return Transition.init(from: from, to: to)
}

/// Represents a valid point for a CAGradientLayer's `startPoint` or `endPoint` when beginning or ending a slide.
struct GradientPoint {
    /// Represents a valid coordinate for either the `x` or the `y` of a `GradientPoint`.
    enum Location: CGFloat {
        case `default` = 0.5
        
        case negativeOne = -1
        case zero = 0
        case one
        case two
    }
    
    /// The x coordinate of the `GradientPoint`
    let x: Location
    
    /// The y coordinate of the `GradientPoint`
    let y: Location
    
    /// Initializes a `GradientPoint` given an x and a y. They both default to `.default`.
    init(x: Location = .default, y: Location = .default) {
        self.x = x
        self.y = y
    }
    
    /// A convenient way to convert a `GradientPoint` to a `CGPoint`.
    var cgPoint: CGPoint {
        return CGPoint(x: x.rawValue, y: y.rawValue)
    }
}

extension CABasicAnimation {
    func applyGradientTransition(_ transition: GradientTransition) {
        fromValue = NSValue(cgPoint: transition.from.cgPoint)
        toValue = NSValue(cgPoint: transition.to.cgPoint)
    }
}

public extension CAGradientLayer {

    fileprivate static let KSlideAnimationKey = "SlideAnimation"

    func slide(direction: GradientDirection) {
        let startPointTransition = direction.transition(for: .startPoint)
        let endPointTransition = direction.transition(for: .endPoint)
        
        let startPointAnim = CABasicAnimation(keyPath: #keyPath(startPoint))
        startPointAnim.applyGradientTransition(startPointTransition)
        
        let endPointAnim = CABasicAnimation(keyPath: #keyPath(endPoint))
        endPointAnim.applyGradientTransition(endPointTransition)
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [startPointAnim, endPointAnim]
        animGroup.duration = 1
        animGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animGroup.repeatCount = .infinity
        
        add(animGroup, forKey: CAGradientLayer.KSlideAnimationKey)
    }

    func stopSliding() {
        removeAnimation(forKey: CAGradientLayer.KSlideAnimationKey)
    }
}

public class GradientView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

extension GradientView {
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    func slide(direction: GradientDirection) {
        return gradientLayer.slide(direction: direction)
    }
    
    func stopSliding() {
        return gradientLayer.stopSliding()
    }
}

enum GradientProperty {
    case startPoint
    case endPoint
}

public enum GradientDirection {
    case right
    case left

    func transition(for point: GradientProperty) -> GradientTransition {
        switch (self, point) {
        case (.right, .startPoint):
            return GradientPoint(x: .negativeOne) --> GradientPoint(x: .one)
        case (.right, .endPoint):
            return GradientPoint(x: .zero) --> GradientPoint(x: .two)
        case (.left, .startPoint):
            return GradientPoint(x: .one) --> GradientPoint(x: .negativeOne)
        case (.left, .endPoint):
            return GradientPoint(x: .two) --> GradientPoint(x: .zero)
        }
    }
}

extension UIColor {
    func brightened(by factor: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * factor, alpha: a)
    }
}
