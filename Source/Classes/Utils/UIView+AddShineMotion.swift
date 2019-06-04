//
//  UIView+AddShineMotion.swift
//  MLCardDrawer
//
//  Created by Juan sebastian Sanzone on 6/3/19.
//

import Foundation

import UIKit

internal extension UIView {
    @discardableResult
    func addShineMotionView(color: UIColor) -> ShineView {
        let shineView = ShineView()
        shineView.clipsToBounds = true
        shineView.color = color
        shineView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width * 2, height: self.frame.height * 6)
        shineView.center = self.center
        self.addSubview(shineView)
        shineView.addMotionEffect()
        return shineView
    }
}
