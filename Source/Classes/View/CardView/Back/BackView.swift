import UIKit

class BackView: CardView {

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .large)
        
        securityCode.formatter = Mask(pattern: [cardUI.securityCodePattern])
        securityCode.setup(model?.securityCode, Default(UIColor.black.withAlphaComponent(0.8)))
        setupCustomOverlayImage(cardUI)
    }

    deinit {
        removeObserver(securityCode, forKeyPath: #keyPath(model.securityCode))
    }
}
