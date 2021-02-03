//
//  SwitchOption.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct SwitchOption {
    var id: String
    var name: String
    var enabled: Bool
    
    public init(id: String, name: String, enabled: Bool) {
        self.id = id
        self.name = name
        self.enabled = enabled
    }
}
