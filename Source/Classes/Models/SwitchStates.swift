//
//  SwitchStates.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct SwitchStates: Codable {
    var checkedState: State
    var uncheckedState: State
    var disabledState: State
    
    enum CodingKeys: String, CodingKey {
        case checkedState = "checked_state"
        case uncheckedState = "unchecked_state"
        case disabledState = "disabled_state"
    }

    public init(checkedState: State, uncheckedState: State, disabledState: State) {
        self.checkedState = checkedState
        self.uncheckedState = uncheckedState
        self.disabledState = disabledState
    }
}
