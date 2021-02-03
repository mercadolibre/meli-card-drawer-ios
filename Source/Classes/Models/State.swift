//
//  SwitchState.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct State {
    var textColor: String
    var backgroundColor: String
    var weight: String
    
    public init(textColor: String, backgroundColor: String, weight: String) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.weight = weight
    }
}

