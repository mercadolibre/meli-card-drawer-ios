//
//  SwitchStates.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct SwitchStates {
    var checkedState: State
    var uncheckedState: State
    var disabledState: State

    public init(checkedState: State, uncheckedState: State, disabledState: State) {
        self.checkedState = checkedState
        self.uncheckedState = uncheckedState
        self.disabledState = disabledState
    }
}
