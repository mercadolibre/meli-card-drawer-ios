//
//  UIColor+DarkLighter.swift
//  MLCardDrawer
//
//  Created by Juan sebastian Sanzone on 6/3/19.
//

import UIKit

internal extension UIColor {
    func lighter(by percentage: CGFloat) -> UIColor {
        return self.adjust(by: abs(percentage))!
    }

    func darker(by percentage: CGFloat) -> UIColor {
        return self.adjust(by: -1 * abs(percentage))!
    }

    func adjust(by percentage: CGFloat) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }

        return UIColor(red: min(red + percentage/100, 1.0),
                       green: min(green + percentage/100, 1.0),
                       blue: min(blue + percentage/100, 1.0),
                       alpha: alpha)
    }
}
