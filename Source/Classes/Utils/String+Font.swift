//
//  String+Font.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 26/03/21.
//

internal extension String {
    
    func getFont(size: CGFloat = 16) -> UIFont {
        switch self {
        case "regular":
            return UIFont.systemFont(ofSize: size, weight: .regular)
        case "semi_bold":
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        case "light":
            return UIFont.systemFont(ofSize: size, weight: .light)
        case "bold":
            return UIFont.systemFont(ofSize: size, weight: .bold)
        default:
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
}
