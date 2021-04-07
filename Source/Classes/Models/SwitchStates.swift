//
//  SwitchStates.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct SwitchStates: Codable {
    var checked: State
    var unchecked: State
    
    enum CodingKeys: String, CodingKey {
        case checked = "checked"
        case unchecked = "unchecked"
    }

    public init(checked: State, unchecked: State) {
        self.checked = checked
        self.unchecked = unchecked
    }
}
