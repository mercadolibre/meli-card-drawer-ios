//
//  ComboSwitchModel.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct SwitchModel: Codable {
    var description : Text?
    var states: SwitchStates
    var options: [SwitchOption]
    var backgroundColor: String
    var defaultState : String
    
    enum CodingKeys: String, CodingKey {
        case description
        case states
        case options
        case backgroundColor = "background_color"
        case defaultState = "default"
    }
    
    public init(description: Text, states: SwitchStates, options: [SwitchOption], backgroundColor: String, defaultState : String) {
        self.description = description
        self.states = states
        self.options = options
        self.backgroundColor = backgroundColor
        self.defaultState = defaultState
    }
}
