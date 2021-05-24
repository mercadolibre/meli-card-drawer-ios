//
//  GenericCardUI.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 04/05/21.
//

import Foundation

@objc public protocol GenericCardUI: CardUI {
    var labelName: String { get }
    var labelTextColor: String { get }
    var labelBackgroundColor: String { get }
    var labelWeight: String { get }
    var titleName: String { get }
    var titleTextColor: String { get }
    var titleWeight: String { get }
    var subtitleName: String { get }
    var subtitleTextColor: String { get }
    var subtitleWeight: String { get }
    var logoImageURL: String { get }
}
