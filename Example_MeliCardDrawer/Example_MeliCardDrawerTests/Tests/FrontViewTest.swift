import XCTest
@testable import Example_MeliCardDrawer
@testable import MLCardDrawer

class FrontViewTest: XCTestCase {

    func testModelObservers() {
        let cardUI = CardUIMock()
        let model = CardDataMock()
        let frontView = FrontView()

        frontView.setup(cardUI, model, .zero)
        frontView.model?.securityCode = "1"

        XCTAssertNotNil(frontView.model)
        XCTAssert(frontView.securityCode.text! == "1**")
        XCTAssert(frontView.securityCode.alpha == 1)
    }

    func testShowCVV() {
        let cardUI = CardUIMock()
        let model = CardDataMock()
        let frontView = FrontView()

        frontView.setup(cardUI, model, .zero)
        frontView.showSecurityCode()

        XCTAssert(frontView.securityCodeCircle.alpha == 1)
    }
}
