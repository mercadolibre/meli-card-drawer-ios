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
    
    public static func getSizeByGoldenAspectRatio(width: CGFloat, type: MLCardDrawerType = .large) -> CGSize {
        let goldenAspectRation: CGFloat = getGoldenRatio(from: type)
        let size = CGSize(width: width, height: width / goldenAspectRation)
        return size
    }
    
    public static func getHeightByGoldenAspectRatio(width: CGFloat, type: MLCardDrawerType = .large) -> CGFloat {
        let goldenAspectRation: CGFloat = getGoldenRatio(from: type)
        return width / goldenAspectRation
    }
    
    public static func getWidthByGoldenAspectRatio(height: CGFloat, type: MLCardDrawerType = .large) -> CGFloat {
        return height * getGoldenRatio(from: type)
    }
    
    public static func getGoldenRatio(from type: MLCardDrawerType) -> CGFloat {
        switch type {
        case .large:
            return goldenRatio
        case .medium:
            return mediumGoldenRatio
        case .small:
            return smallGoldenRatio
        }
    }
}
