import XCTest
@testable import Example_MeliCardDrawer
@testable import MLCardDrawer

class FrontViewTest: XCTestCase {

    func testModelObservers() {
        let cardUI = CardUIMock()
        let model = CardDataMock()
        let frontView = FrontView()

        frontView.setup(cardUI, model, .zero, true, customLabelFontName: nil)
        frontView.model?.name = "JOHN"
        frontView.model?.number = "123"
        frontView.model?.securityCode = "1"
        frontView.model?.expiration = "10/19"
        
        XCTAssertNotNil(frontView.model)
        XCTAssert(frontView.name.text! == "JOHN")
        XCTAssertEqual(frontView.number.text, "123* **** ****")
        XCTAssert(frontView.securityCode.text! == "1**")
        XCTAssert(frontView.expirationDate.text! == "10/19")
        XCTAssert(frontView.securityCode.alpha == 1)
    }

    func testCardUIDidChange() {
        let cardUI = CardUIMock()
        let model = CardDataMock()
        let frontView = FrontView()

        frontView.setup(cardUI, model, .zero, true, customLabelFontName: nil)
        cardUI.cardPattern = [3, 3]
        frontView.setupUI(cardUI)

        XCTAssertEqual(frontView.number.text, "***         ***")
    }

    func testShowCVV() {
        let cardUI = CardUIMock()
        let model = CardDataMock()
        let frontView = FrontView()

        frontView.setup(cardUI, model, .zero, true, customLabelFontName: nil)
        frontView.showSecurityCode()

        XCTAssert(frontView.securityCodeCircle.alpha == 1)
    }
}
