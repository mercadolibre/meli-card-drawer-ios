//
//  CardCornerRadiusManager.swift
//  MLCardDrawer
//
//  Created by JONATHAN DANIEL BANDONI on 12/11/2019.
//

import Foundation

public class CardCornerRadiusManager {
    
    static let largeCornerRadius: CGFloat = 8
    static let mediumCornerRadius: CGFloat = 6
    static let smallCornerRadius: CGFloat = 6
    
    public static func getCornerRadius(from type: MLCardDrawerType) -> CGFloat {
        switch type {
        case .large:
            return largeCornerRadius
        case .medium:
            return mediumCornerRadius
        case .small:
            return smallCornerRadius
        }
    }
}
