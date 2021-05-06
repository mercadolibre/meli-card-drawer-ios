//
//  GenericCardUI.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 04/05/21.
//

import Foundation

@objc public protocol GenericCardUI: CardUI {
    var titleName: String { get }
    var subtitleName: String { get }
}
