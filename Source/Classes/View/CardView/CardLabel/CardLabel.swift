import UIKit

class CardLabel: UILabel {

    let fontName = "Roboto Mono"
    var formatter = Mask(pattern: [])
    var typeFont: Font = Light(shadow: false)
    var dynamicSlice = true

    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont(name: fontName, size: font.fontDescriptor.pointSize)
    }

    func setup(_ text: String?, _ textType: Font? = nil) {
        typeFont = textType ?? typeFont
        textColor = typeFont.color
        let color = typeFont.gradient.getGradient(frame)
        attributedText = formatter.format(text, typeFont, totalPad(), color)
    }

    func totalPad() -> Int {
        return dynamicSlice ? Int(frame.width / font.size(" ").width) : 0
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        guard let change = change, let new = change[.newKey] else { return }
        setup(new as? String)
    }
}
