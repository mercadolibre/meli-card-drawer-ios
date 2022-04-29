//
//  AccountsBankCardUI.swift
//  MLCardDrawer
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 25/03/22.
//

import Foundation

@objc public enum PaymentMethod: Int, RawRepresentable {
    case debin
    case openFinance
    case other

    public init?(rawValue: String) {
        switch rawValue {
            case "debin_transfer":
                self = .debin
            case "pix_openfinance":
                self = .openFinance
            default:
                self = .other
        }
    }
    
    public var text: String {
        switch self {
        case .debin:
            return "DEBIN"
        case .openFinance:
            return "OPEN FINANCE"
        default:
            return ""
        }
    }
}

@objc public protocol AccountBankingCardUIDelegate: NSObjectProtocol {
  func didSelectTermsView(url: String, title: String)
}

@objc public protocol AccountsBankCardUI: CardUI {
    weak var delegate: AccountBankingCardUIDelegate? { get set }
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
    var termsMessage: String { get }
    var termsTextColor: String { get }
    var termsLink: String { get }
    var termsTextLink: String { get }
    var termsColorLink: String { get }
    var paymentMethodId: PaymentMethod { get }
     
}
