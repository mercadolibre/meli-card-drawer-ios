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
    
    let tagBottom: Text? = Text(message: "saldo em conta", textColor: "#F0F0F0", weight: "semi_bold")

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
    
    func test_valid_type_medium() {
        let padding: UIEdgeInsets = .init(top: 0, left: 0, bottom: 40, right: 0)
        let carTypeSpy: MLCardDrawerTypeV3 = .medium
        let cardUI = CardUIMock()
        let model = CardDataMock()
        cardUI.securityCodeLocation = .front
        let cardController = MLCardDrawerController(cardUI, model)
        cardController.frontView.addTagBottom(containerView: UIView(), isDisabled: true, cardType: carTypeSpy, tagBottom: tagBottom, padding: padding)
        XCTAssertEqual(carTypeSpy, MLCardDrawerTypeV3.medium)
    }
    
    func test_valid_type_large(){
        let padding: UIEdgeInsets = .init(top: 0, left: 0, bottom: 40, right: 0)
        let carTypeSpy: MLCardDrawerTypeV3 = .large
        let cardUI = CardUIMock()
        let model = CardDataMock()
        cardUI.securityCodeLocation = .front
        let cardController = MLCardDrawerController(cardUI, model)
        cardController.frontView.addTagBottom(containerView: UIView(), isDisabled: true, cardType: carTypeSpy, tagBottom: tagBottom, padding: padding)
        XCTAssertEqual(carTypeSpy, MLCardDrawerTypeV3.large)
    }
    
    func test_valid_type_mini() {
        let padding: UIEdgeInsets = .init(top: 0, left: 0, bottom: 40, right: 0)
        let carTypeSpy: MLCardDrawerTypeV3 = .mini
        let cardUI = CardUIMock()
        let model = CardDataMock()
        cardUI.securityCodeLocation = .front
        let cardController = MLCardDrawerController(cardUI, model)
        cardController.frontView.addTagBottom(containerView: UIView(), isDisabled: true, cardType: carTypeSpy, tagBottom: tagBottom, padding: padding)
        XCTAssertEqual(carTypeSpy, MLCardDrawerTypeV3.mini)
    }
    
    func test_valid_type_xSmall() {
        let padding: UIEdgeInsets = .init(top: 0, left: 0, bottom: 40, right: 0)
        let carTypeSpy: MLCardDrawerTypeV3 = .xSmall
        let cardUI = CardUIMock()
        let model = CardDataMock()
        cardUI.securityCodeLocation = .front
        let cardController = MLCardDrawerController(cardUI, model)
        cardController.frontView.addTagBottom(containerView: UIView(), isDisabled: true, cardType: carTypeSpy, tagBottom: tagBottom, padding: padding)
        XCTAssertEqual(carTypeSpy, MLCardDrawerTypeV3.xSmall)
    }
}
