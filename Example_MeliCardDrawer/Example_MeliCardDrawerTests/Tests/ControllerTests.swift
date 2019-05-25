//
//  ControllerTests.swift
//  Example_MeliCardDrawerTests
//
//  Created by Juan sebastian Sanzone on 5/22/19.
//  Copyright © 2019 Mercadolibre. All rights reserved.
//

import Foundation
import XCTest
@testable import Example_MeliCardDrawer
@testable import MLCardDrawer

class CardHeaderControllerTest: XCTestCase {

    func testShow() {
        let cardUI = CardUIMock()
        let model = CardDataMock()
        let cardController = MLCardDrawerController(cardUI, model)

        cardController.show()

        XCTAssertTrue(cardController.frontView.isDescendant(of: cardController.view))
        XCTAssertFalse(cardController.backView.isDescendant(of: cardController.view))
    }

    func testShowFrontSecurityCode() {
        let cardUI = CardUIMock()
        let model = CardDataMock()
        let cardController = MLCardDrawerController(cardUI, model)

        cardController.showSecurityCode()

        XCTAssertTrue(cardController.frontView.isDescendant(of: cardController.view))
        XCTAssertFalse(cardController.backView.isDescendant(of: cardController.view))
    }

    func testShowBackSecurityCode() {
        let cardUI = CardUIMock()
        let model = CardDataMock()
        let cardController = MLCardDrawerController(cardUI, model)

        cardUI.securityCodeLocation = .back
        cardController.showSecurityCode()

        XCTAssertTrue(cardController.backView.isDescendant(of: cardController.view))
        XCTAssertFalse(cardController.frontView.isDescendant(of: cardController.view))
    }

    func testFlipAnimation() {
        let cardUI = CardUIMock()
        let model = CardDataMock()
        cardUI.securityCodeLocation = .back
        let cardController = MLCardDrawerController(cardUI, model)

        cardController.show()
        cardController.showSecurityCode()

        XCTAssertTrue(cardController.backView.isDescendant(of: cardController.view))
    }

    func testOverlayAnimation() {
        let cardUI = CardUIMock()
        let model = CardDataMock()
        let cardController = MLCardDrawerController(cardUI, model)

        cardController.show()
        cardController.cardUI = cardUI

        XCTAssertTrue(cardController.frontView.isDescendant(of: cardController.view))
    }
}
