import XCTest
@testable import Example_MeliCardDrawer
@testable import MLCardDrawer

class FrontViewTest: XCTestCase {
    var sutCardData: CardData!
    
    let cardBalanceModel = CardBalanceModel(title: nil,
                                            balance: .init(message: "Show",
                                                           textColor: "#FFFFF",
                                                           weight: "normal"),
                                            hiddenBalance: .init(message: "Hide",
                                                                 textColor: "#FFFFF",
                                                                 weight: "normal"))
    
    override func setUp() {
        super.setUp()
        sutCardData = CardDataMock()
    }
    
    func testAddCardBalance() {
        let cardView = FrontView()
        let cardUI = CardUIMock()
        cardView.setup(cardUI, sutCardData, .zero, false, customLabelFontName: nil)
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
    
    func testToggleBalance() {
        let cardView = FrontView()
        let cardUI = CardUIMock()
        cardView.setup(cardUI, sutCardData, .zero, false, customLabelFontName: nil)
        
        let cardBalanceDelegateSpy = CardBalanceDelegateSpy()
        
        cardView.addCardBalance(cardBalanceModel, false, cardBalanceDelegateSpy)
        
        XCTAssertFalse(cardView.cardBalanceContainer.showBalance)
        XCTAssertFalse(cardBalanceDelegateSpy.handlerToggleBalance)
        
        cardView.toggleCardBalance()
        
        XCTAssertTrue(cardView.cardBalanceContainer.showBalance)
        XCTAssertTrue(cardBalanceDelegateSpy.handlerToggleBalance)
    }

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
    
    class CardBalanceDelegateSpy: CardBalanceDelegate {
        var handlerToggleBalance = false

        func toggleBalance() -> Bool {
            handlerToggleBalance = true
            return true
        }
    }
}
