import UIKit

internal extension UIFont {
    static func registerFont(fontName: String, fontExtension: String) {
        let resource: String = "Fonts"
        let type: String = "bundle"
        if let targetPath = Bundle.main.path(forResource: resource, ofType: type) {
            doRegister(targetPath, fontName: fontName, fontExtension: fontExtension)
        } else if let auxPath = Bundle.init(for: MLCardDrawerController.self).path(forResource: resource, ofType: type) {
            doRegister(auxPath, fontName: fontName, fontExtension: fontExtension)
        }
    }

    static func doRegister(_ bundlePath: String, fontName: String, fontExtension: String) {
        guard
            let bundle = Bundle(path: bundlePath),
            let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
            let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
            let font = CGFont(fontDataProvider),
            CTFontManagerRegisterGraphicsFont(font, nil) else { return }
    }

    func size(_ string: String) -> CGSize {
        return (string as NSString).size(withAttributes: [.font: self])
    }
}
