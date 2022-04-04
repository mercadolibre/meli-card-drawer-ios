//
//  AccountsBankCardUI.swift
//  MLCardDrawer
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 25/03/22.
//

import Foundation

@objc public protocol AccountsBankCardUI: CardUI {
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
    var descriptionName: String { get }
    var descriptionTextColor: String { get }
    var descriptionWeight: String { get }
    var gradientColors: [String] { get }
}
