//
//  GoldenRatio.swift
//  MLCardDrawer
//
//  Created by Jonatan Urquiza on 7/18/19.
//

import Foundation

public class CardSizeManager {
    
    static let goldenRatio: CGFloat = 1.586
    static let mediumGoldenRatio: CGFloat = 343/88
    static let smallGoldenRatio: CGFloat = 7
    static let xSmallGoldenRatio: CGFloat = 1/0.265
    static let miniGoldenRatio: CGFloat = 1/0.14
    
    public static func getSizeByGoldenAspectRatio(width: CGFloat, type: MLCardDrawerTypeV3 = .large) -> CGSize {
        let goldenAspectRation: CGFloat = getGoldenRatio(from: type)
        let size = CGSize(width: width, height: width / goldenAspectRation)
        return size
    }
    
    public static func getHeightByGoldenAspectRatio(width: CGFloat, type: MLCardDrawerTypeV3 = .large) -> CGFloat {
        let goldenAspectRation: CGFloat = getGoldenRatio(from: type)
        return width / goldenAspectRation
    }
    
    public static func getWidthByGoldenAspectRatio(height: CGFloat, type: MLCardDrawerTypeV3 = .large) -> CGFloat {
        return height * getGoldenRatio(from: type)
    }
    
    public static func getGoldenRatio(from type: MLCardDrawerTypeV3) -> CGFloat {
        switch type {
        case .large:
            return goldenRatio
        case .medium:
            return mediumGoldenRatio
        case .small:
            return smallGoldenRatio
        case .xSmall:
            return xSmallGoldenRatio
        case .mini:
            return miniGoldenRatio
        }
    }
}
