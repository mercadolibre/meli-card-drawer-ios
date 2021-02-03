//
//  ComboSwitchModel.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct SwitchModel {
    var description : Text
    var states: SwitchStates
    var options: [SwitchOption]
    var backgroundColor: String
    var defaultState : String
    
    public init(description: Text, states: SwitchStates, options: [SwitchOption], backgroundColor: String, defaultState : String) {
        self.description = description
        self.states = states
        self.options = options
        self.backgroundColor = backgroundColor
        self.defaultState = defaultState
    }
}
