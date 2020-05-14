import UIKit

class CardLabel: UILabel {
    // MARK: - Properties
    var formatter = Mask(pattern: [])
    var typeFont: Font = Light(shadow: false)
    var dynamicSlice = true

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(_ text: String?, _ textType: Font? = nil, customLabelFontName: String? = nil) {
        font = UIFont(name: customLabelFontName ?? Constants.fontName, size: font.fontDescriptor.pointSize)
        typeFont = textType ?? typeFont
        textColor = typeFont.color
        let color = typeFont.gradient.getGradient(frame)
        attributedText = formatter.format(text, typeFont, totalPad(), color)
    }

    func totalPad() -> Int {
        let kerning = formatter.attributes[.kern] as? Double ?? 0
        let value = frame.width / font.size(" ", kerning: kerning).width
        return dynamicSlice ? Int(value) : 0
    }

    //MARK: Observers
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        guard let change = change, let new = change[.newKey] else { return }
        setup(new as? String, customLabelFontName: self.font.fontName)
    }
}

// MARK: - Constants
extension CardLabel {
    
    struct Constants {
        static let fontName = "Roboto Mono"
    }
}
