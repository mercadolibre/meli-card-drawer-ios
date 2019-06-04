//
//  ShineView.swift
//  MLCardDrawer
//
//  Created by Juan sebastian Sanzone on 6/3/19.
//

import UIKit

internal final class ShineView: UIView {
    let motionEffectGroup = UIMotionEffectGroup()
    let motionEffectGroup2 = UIMotionEffectGroup()

    public init() {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var color: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let lightestColor = color.lighter(by: 50).cgColor
        let lightColor = color.lighter(by: 30).cgColor
        let darkColor = color.darker(by: 40).cgColor
        let darkestColor = color.darker(by: 50).cgColor
        let colors = [lightestColor, lightColor, color.cgColor, darkColor, darkestColor]

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let colorLocations: [CGFloat] = [0, 0.2, 0.5, 0.8, 1.0]

        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!

        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }

    func addMotionEffect() {
        removeMotionEffects()
        let xRotation = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.x", type: .tiltAlongVerticalAxis)
        xRotation.minimumRelativeValue = 0.2
        xRotation.maximumRelativeValue = -0.2

        let xTras = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        xTras.minimumRelativeValue = -10
        xTras.maximumRelativeValue = 10

        let yTras = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yTras.minimumRelativeValue = -10
        yTras.maximumRelativeValue = 10

        motionEffectGroup.motionEffects = [xRotation, yTras, xTras]

        self.addMotionEffect(motionEffectGroup)

        let yMotionGrad = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yMotionGrad.minimumRelativeValue = 350
        yMotionGrad.maximumRelativeValue = -350

        let xRot = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.z", type: .tiltAlongHorizontalAxis)
        xRot.minimumRelativeValue = -1.5
        xRot.maximumRelativeValue = 1.5

        motionEffectGroup2.motionEffects = [xRot, yMotionGrad]

        self.addMotionEffect(motionEffectGroup2)
    }

    func removeMotionEffects() {
        removeMotionEffect(motionEffectGroup)
        removeMotionEffect(motionEffectGroup2)
        for targetMotion in motionEffects {
            removeMotionEffect(targetMotion)
        }
    }
}
