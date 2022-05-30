//
//  MLCardDrawerTypeV3.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 29/06/2021.
//

import Foundation

@objc public enum MLCardDrawerTypeV3: Int, CustomStringConvertible {
    
    case mini, xSmall, small, medium, large
    
    public var description: String {
        switch self {
        case .mini: return "mini"
        case .xSmall: return "xSmall"
        case .small: return "small"
        case .medium: return "medium"
        case .large: return "large"
        }
    }
    
}
