//
//  Text.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct Text: Codable {
    var textColor: String?
    let backgroundColor: String?
    var message: String?
    var weight: String?
    
    enum CodingKeys: String, CodingKey {
        case textColor = "text_color"
        case backgroundColor = "background_color"
        case message
        case weight
    }
    
    public init(message: String?, textColor: String?, weight: String?, backgroundColor: String?) {
        self.message = message
        self.textColor = textColor
        self.weight = weight
        self.backgroundColor = backgroundColor
    }
    
    public init(message: String, textColor: String, weight: String) {
        self.message = message
        self.textColor = textColor
        self.weight = weight
        self.backgroundColor = nil
    }
}
