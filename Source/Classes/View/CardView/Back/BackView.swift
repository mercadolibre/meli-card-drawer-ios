import UIKit

class BackView: CardView {
    @IBOutlet weak var overlayImage: UIImageView!

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        securityCode.setup(model?.securityCode, Default(UIColor.gray))
        setupCustomOverlayImage(cardUI)
    }

    deinit {
        removeObserver(securityCode, forKeyPath: #keyPath(model.securityCode))
    }
}

// MARK: Privates
extension BackView {
    private func setupCustomOverlayImage(_ cardUI: CardUI) {
        if let customOverlayImage = cardUI.ownOverlayImage {
            overlayImage.image = customOverlayImage
        }
    }
}
