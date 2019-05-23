//
//  FormatterTests.swift
//  Example_MeliCardDrawerTests
//
//  Created by Juan sebastian Sanzone on 5/22/19.
//  Copyright © 2019 Mercadolibre. All rights reserved.
//

import Foundation
import XCTest
@testable import Example_MeliCardDrawer
@testable import MeliCardDrawer

class MaskFormatterTest: XCTestCase {
    
    func testMaskText() {
        XCTAssert(Mask(pattern: [4, 3, 4]).format("123", Light(), 13).string == "123* *** ****")
    }

    func testMaskEmptyText() {
        XCTAssert(Mask(pattern: [4, 3, 4]).format("", Light(), 13).string == "**** *** ****")
    }

    func testMaskNilText() {
        XCTAssert(Mask(pattern: [4, 3, 4]).format(nil, Light(), 13).string == "**** *** ****")
    }

    func testMaskTextWithLastDigits() {
        XCTAssert(Mask(pattern: [4, 3, 4], digits:"1234").format("", Light(), 13).string == "**** *** 1234")
    }
}
