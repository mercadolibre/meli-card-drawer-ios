//
//  CardBalanceText.swift
//  MLCardDrawer
//
//  Created by Matheus Cavalcante Teixeira on 24/06/22.
//

public struct CardBalanceText: Codable {
    let message: String?
    let backgroundColor: String?
    let textColor: String?
    let weight: String?
    let defaultTextColor: UIColor = .white
    let defaultBackgroundColor: UIColor = .clear
    
    enum CodingKeys: String, CodingKey {
        case message
        case backgroundColor = "background_color"
        case textColor = "text_color"
        case weight
    }
}
