//
//  Text.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct Text: Codable {
    var text: String?
    var textColor: String?
    var weight: String?
    
    public init(text: String, textColor: String, weight: String) {
        self.text = text
        self.textColor = textColor
        self.weight = weight
    }
}
