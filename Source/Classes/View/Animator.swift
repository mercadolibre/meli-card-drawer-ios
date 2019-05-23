import Foundation
import UIKit

class Animator {

    static let duration = 0.6

    class func overlay(on view: CardView,
                       cardUI: CardUI,
                       views: [UIView],
                       complete: @escaping ()->()) {

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            views.forEach({ $0.alpha = 0.4 })
        }, completion: {(true)  in
            let color = view.animation.backgroundColor
            complete()
            view.animation.backgroundColor = color

            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                views.forEach({ $0.alpha = 1 })
            }, completion: nil)
        })

        let ovalSize = CGSize(width: view.frame.width * 2, height: view.frame.height * 2)
        let ovalOrigin = CGPoint(x: -view.frame.width * 2, y: -view.frame.height * 2)
        var toPath = UIBezierPath.init(ovalIn: CGRect(origin: CGPoint.zero, size: ovalSize)).cgPath
        var fromPath = UIBezierPath.init(ovalIn: CGRect(origin: ovalOrigin, size: ovalSize)).cgPath

        let ellipseLayer = CAShapeLayer()
        ellipseLayer.bounds = view.animation.layer.frame
        ellipseLayer.fillColor = cardUI.cardBackgroundColor.cgColor

        if cardUI.defaultUI {
            swap(&toPath, &fromPath)
            ellipseLayer.fillColor = view.animation.layer.backgroundColor
            view.animation.backgroundColor = cardUI.cardBackgroundColor
        }

        view.animation.layer.addSublayer(ellipseLayer)
        ellipseLayer.path = fromPath

        CATransaction.begin()
        CATransaction.setAnimationDuration(0.4)
        let timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        CATransaction.setAnimationTimingFunction(timingFunction)
        CATransaction.setCompletionBlock {
            ellipseLayer.removeFromSuperlayer()
            complete()
        }

        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.toValue = toPath
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = CAMediaTimingFillMode.forwards
        ellipseLayer.add(pathAnimation, forKey: nil)

        CATransaction.commit()
    }

    class func flip(_ origin: UIView,
                    _ destination: UIView,
                    _ options: UIView.AnimationOptions) {

        UIView.transition(from: origin,
                          to: destination,
                          duration: Animator.duration,
                          options: options,
                          completion: nil)
    }
}
