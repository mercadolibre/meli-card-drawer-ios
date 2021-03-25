//
//  Text.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct Text: Codable {
    var textColor: String?
    var text: String?
    var weight: String?
    
    enum CodingKeys: String, CodingKey {
        case textColor = "text_color"
        case text
        case weight
    }
    
    public init(text: String, textColor: String, weight: String) {
        self.text = text
        self.textColor = textColor
        self.weight = weight
    }
}
