import UIKit

class SmallBackView: CardView {

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        securityCode.setup(model?.securityCode, Default(UIColor.gray))
        setupCustomOverlayImage(cardUI)
    }

    deinit {
        removeObserver(securityCode, forKeyPath: #keyPath(model.securityCode))
    }
}
