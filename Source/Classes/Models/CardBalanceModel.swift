//
//  CardBalanceModel.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 13/06/22.
//

import Foundation

public struct CardBalanceModel: Codable {
    let title: CardBalanceText
    let balance: CardBalanceText
    let hiddenBalance: CardBalanceText
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case balance = "value"
        case hiddenBalance = "hidden_value"
    }
}
