//
//  SwitchState.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct State: Codable {
    var textColor: String
    var weight: String
    
    enum CodingKeys: String, CodingKey {
        case textColor = "text_color"
        case weight
    }
    
    public init(textColor: String, weight: String) {
        self.textColor = textColor
        self.weight = weight
    }
}

