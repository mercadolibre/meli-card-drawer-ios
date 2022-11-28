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
    func testAddGradientCustomCardAndOwnGradient() {
        // Given
        let expectedGradient = CAGradientLayer()
        expectedGradient.endPoint = .init(x: 5, y: 5)
        expectedGradient.startPoint = .init(x: 1, y: 1)
        expectedGradient.colors = [ UIColor.white, UIColor.black ]
        let customCardUI = CustomCardDrawerUIMock()
        customCardUI.ownGradient = expectedGradient
        let dataMock = CardDataMock()
        let cardView = FrontView()
        let expectedFrame: CGRect = .init(x: 2, y: 2, width: 100, height: 100)
        
        // When
        cardView.setup(customCardUI, dataMock, expectedFrame)
        
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
}
    
