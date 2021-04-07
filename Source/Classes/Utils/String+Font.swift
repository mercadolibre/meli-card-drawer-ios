//
//  String+Font.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 26/03/21.
//

internal extension String {
    
    func getFont() -> UIFont {
        switch self {
        case "regular":
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        case "semi_bold":
            return UIFont.systemFont(ofSize: 16, weight: .semibold)
        case "light":
            return UIFont.systemFont(ofSize: 16, weight: .light)
        case "bold":
            return UIFont.systemFont(ofSize: 16, weight: .bold)
        default:
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
}
