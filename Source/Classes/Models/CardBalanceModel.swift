//
//  CardBalanceModel.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 13/06/22.
//

import Foundation

public struct CardBalanceModel: Codable {
    let balanceTitle: Text
    let balance: Text
    let coin: Text
    
    enum CodingKeys: String, CodingKey {
        case balanceTitle
        case balance
        case coin
    }
}
