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
    
    func test_valid_type_medium() {
        let sut = makeSut()
        let carTypeSpy = makeTypeV3(cardTypeSpy: .medium)
        let addTagBottomSpy = AddTagBottomSpy()
        addTagBottomSpy.addTagBottom(containerView: sut.getCardView(), isDisabled: false, cardType: carTypeSpy, tagBottom: makeBottomTag(), padding: .zero)
        XCTAssertEqual(addTagBottomSpy.cardType, carTypeSpy)
        XCTAssertEqual(addTagBottomSpy.isDisabled, false)
    }

    func test_valid_type_large(){
        let sut = makeSut()
        let carTypeSpy = makeTypeV3(cardTypeSpy: .large)
        let addTagBottomSpy = AddTagBottomSpy()
        addTagBottomSpy.addTagBottom(containerView: sut.getCardView(), isDisabled: false, cardType: carTypeSpy, tagBottom: makeBottomTag(), padding: .zero)
        XCTAssertEqual(addTagBottomSpy.cardType, carTypeSpy)
        XCTAssertEqual(addTagBottomSpy.isDisabled, false)
    }

    func test_valid_type_mini() {
        let sut = makeSut()
        let carTypeSpy = makeTypeV3(cardTypeSpy: .mini)
        let addTagBottomSpy = AddTagBottomSpy()
        addTagBottomSpy.addTagBottom(containerView: sut.getCardView(), isDisabled: false, cardType: carTypeSpy, tagBottom: makeBottomTag(), padding: .zero)
        XCTAssertEqual(addTagBottomSpy.cardType, carTypeSpy)
        XCTAssertEqual(addTagBottomSpy.isDisabled, false)
    }
    
    func test_valid_type_xSmall() {
        let sut = makeSut()
        let carTypeSpy = makeTypeV3(cardTypeSpy: .xSmall)
        let addTagBottomSpy = AddTagBottomSpy()
        addTagBottomSpy.addTagBottom(containerView: sut.getCardView(), isDisabled: false, cardType: carTypeSpy, tagBottom: makeBottomTag(), padding: .zero)
        XCTAssertEqual(addTagBottomSpy.cardType, carTypeSpy)
        XCTAssertEqual(addTagBottomSpy.isDisabled, false)
    }
}

extension CardHeaderControllerTest {
    func makeTypeV3(cardTypeSpy: MLCardDrawerTypeV3) -> MLCardDrawerTypeV3{
        return cardTypeSpy
    }
    
    func makeSut() -> MLCardDrawerController{
        let cardUI = CardUIMock()
        let model = CardDataMock()
        return MLCardDrawerController(cardUI, model)
    }
    
    func makeBottomTag() -> Text?{
        return Text(message: "saldo em conta", textColor: "#F0F0F0", weight: "semi_bold")
    }
    
    class AddTagBottomSpy: CapabilitiesComponentsViewProtocol {
        var isDisabled: Bool?
        var cardType:MLCardDrawerTypeV3?
        var tagBottom: Text?
        
        func addTagBottom(containerView: UIView, isDisabled: Bool, cardType: MLCardDrawer.MLCardDrawerTypeV3, tagBottom: MLCardDrawer.Text?, padding: UIEdgeInsets) {
            self.cardType = cardType
            self.tagBottom = tagBottom
            self.isDisabled = isDisabled
        }
    }
}
