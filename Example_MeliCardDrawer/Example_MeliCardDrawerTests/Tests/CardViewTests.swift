//
//  CardViewTests.swift
//  Example_MeliCardDrawerTests
//
//  Created by Jose Ricardo Ventrilho Filho on 16/11/22.
//  Copyright © 2022 Mercadolibre. All rights reserved.
//

import XCTest
@testable import Example_MeliCardDrawer
@testable import MLCardDrawer

class CardViewTests: XCTestCase {
    var sutCardData: CardData!
    
    override func setUp() {
        super.setUp()
        sutCardData = CardDataMock()
    }
    
    func testAddCardBalance() {
        let cardView = FrontView()
        let cardUI = CardUIMock()
        cardView.setup(cardUI, sutCardData, .zero, false, customLabelFontName: nil)
        
        let cardBalanceModel = CardBalanceModel(title: nil,
                                                balance: .init(message: "Show",
                                                               textColor: "#FFFFF",
                                                               weight: "normal"),
                                                hiddenBalance: .init(message: "Hide",
                                                                     textColor: "#FFFFF",
                                                                     weight: "normal"))
        let cardBalanceDelegateSpy = CardBalanceDelegateSpy()
        
        XCTAssertNil(cardView.cardBalanceContainer.model)
        XCTAssertFalse(cardBalanceDelegateSpy.handlerToggleBalance)
        
        cardView.addCardBalance(cardBalanceModel, true, cardBalanceDelegateSpy)
        
        XCTAssertEqual(cardView.cardBalanceContainer.model?.hiddenBalance.message, "Hide")
        XCTAssertEqual(cardView.cardBalanceContainer.model?.balance.message, "Show")
        XCTAssertTrue(cardView.cardBalanceContainer.showBalance)
        
        _ = cardView.cardBalanceContainer.delegate?.toggleBalance()
        
        XCTAssertTrue(cardBalanceDelegateSpy.handlerToggleBalance)
    }
    
    func testAddGradientCustomCardAndOwnGradient() {
        // Given
        let expectedGradient = CAGradientLayer()
        expectedGradient.endPoint = .init(x: 5, y: 5)
        expectedGradient.startPoint = .init(x: 1, y: 1)
        expectedGradient.colors = [ UIColor.white, UIColor.black ]
        let customCardUI = CustomCardDrawerUIMock()
        customCardUI.ownGradient = expectedGradient
        let cardView = FrontView()
        let expectedFrame: CGRect = .init(x: 2, y: 2, width: 100, height: 100)
        
        // When
        cardView.setup(customCardUI, sutCardData, expectedFrame, true, customLabelFontName: nil)
        
        // Then
        XCTAssertNotNil(cardView.layer.sublayers)
        XCTAssertEqual(cardView.layer.sublayers?.count, 1)
        guard let gradientAdded = cardView.gradient.layer.sublayers?.first as? CAGradientLayer else {
            XCTFail("Hasn't expected sublayer...")
            return
        }
        XCTAssertEqual(gradientAdded.frame, expectedFrame)
        XCTAssertNotNil(gradientAdded.colors?.first as? UIColor)
        XCTAssertNotNil(gradientAdded.colors?.last as? UIColor)
        XCTAssertEqual(gradientAdded.colors?.first as? UIColor, expectedGradient.colors?.first as? UIColor)
        XCTAssertEqual(gradientAdded.colors?.last as? UIColor, expectedGradient.colors?.last as? UIColor)
        XCTAssertEqual(gradientAdded.endPoint, expectedGradient.endPoint)
        XCTAssertEqual(gradientAdded.startPoint, expectedGradient.startPoint)
    }
    
    class CardBalanceDelegateSpy: CardBalanceDelegate {
        var handlerToggleBalance = false

        func toggleBalance() -> Bool {
            handlerToggleBalance = true
            return true
        }
    }
}
    
