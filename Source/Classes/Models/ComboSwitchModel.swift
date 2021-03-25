//
//  ComboSwitchModel.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 31/01/2021.
//

public struct SwitchModel: Codable {
    let description: Text
    let states: SwitchStates
    let defaultState: String
    let switchBackgroundColor: String
    let pillBackgroundColor: String
    let safeZoneBackgroundColor: String
    public let options: [SwitchOption]
    
    enum CodingKeys: String, CodingKey {
        case description
        case states
        case defaultState = "default"
        case switchBackgroundColor = "switch_background_color"
        case pillBackgroundColor = "pill_background_color"
        case safeZoneBackgroundColor = "safe_zone_background_color"
        case options
    }
    
    public init(description: Text, states: SwitchStates, defaultState: String, switchBackgroundColor: String, pillBackgroundColor: String, safeZoneBackgroundColor: String, options: [SwitchOption]) {
        self.description = description
        self.states = states
        self.defaultState = defaultState
        self.switchBackgroundColor = switchBackgroundColor
        self.pillBackgroundColor = pillBackgroundColor
        self.safeZoneBackgroundColor = safeZoneBackgroundColor
        self.options = options
    }
}
