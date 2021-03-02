//
//  SwitchOption.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct SwitchOption: Codable {
    public var id: String
    var name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
