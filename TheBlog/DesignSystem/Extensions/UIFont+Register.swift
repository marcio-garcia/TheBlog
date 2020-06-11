import UIKit

enum RegisterFontError: Error {
    case invalidFontFile
    case fontPathNotFound
    case initFontError
    case registerFailed
}

extension UIFont {
    static func register(fileNameString: String, type: String) -> RegisterFontError? {

        let frameworkBundle = Bundle(for: AvatarView.self)
        guard let resourceBundleURL = frameworkBundle.path(forResource: fileNameString,
                                                           ofType: type) else {
            return RegisterFontError.fontPathNotFound
        }
        guard let fontData = NSData(contentsOfFile: resourceBundleURL), let dataProvider = CGDataProvider(data: fontData) else {
            return RegisterFontError.invalidFontFile
        }
        guard let fontRef = CGFont(dataProvider) else {
            return RegisterFontError.initFontError
        }
        var errorRef: Unmanaged<CFError>?
        guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) else {
            return RegisterFontError.registerFailed
        }
        return nil
    }
}
