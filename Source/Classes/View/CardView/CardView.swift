import UIKit

@objc(MLCardView)
public class CardView: BaseCardView {
    
    @IBOutlet weak var overlayImage: UIImageView!
    
    
    public init() {
        super.init(frame: .zero)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImage(image: UIImage?, disabledMode: Bool) -> UIImage? {
        if disabledMode {
            return image?.imageGreyScale()
        }
        return image
    }
    
    func setupCardLogo(in container: UIImageView) {
        if let cardLogoImage = cardUI?.cardLogoImage {
            container.image = setupImage(image: cardLogoImage, disabledMode: disabledMode)
        }
        cardUI?.set?(logo: container)
    }
    
    func setupBankImage(in container: UIImageView) {
        if let bankImage = cardUI?.bankImage {
            container.image = setupImage(image: bankImage, disabledMode: disabledMode)
        }
        cardUI?.set?(bank: container)
    }
    
    func addCardBalance(_ model: CardBalanceModel, _ showBalance: Bool, _ delegate: CardBalanceDelegate) {}
    
    func toggleCardBalance() {}
    
    func isCardBalanceHidden() -> Bool { false }
}

// MARK: Card View Effects
extension CardView {
    func setupCustomOverlayImage(_ cardUI: CardUI) {
        if let customOverlayImage = cardUI.ownOverlayImage {
            overlayImage.image = customOverlayImage
        }
    }
    
    static public func createTagBottom(_ text: Text) -> UILabel {
        let tagBottomLabel = TagBottom()
        tagBottomLabel.font = text.getFont()
        tagBottomLabel.text =  text.message?.uppercased()
        tagBottomLabel.textColor = text.getTextColor()
        tagBottomLabel.backgroundColor = text.getBackgroundColor()
        tagBottomLabel.sizeToFit()
        return tagBottomLabel
    }
}
