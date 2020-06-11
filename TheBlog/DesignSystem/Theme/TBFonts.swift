import UIKit

enum TBFonts: String {
    case roboto = "Roboto"
}

private let boldFontName = "\(TBFonts.roboto.rawValue)-Bold"
private let regularFontName = "\(TBFonts.roboto.rawValue)-Regular"
private let mediumFontName = "\(TBFonts.roboto.rawValue)-Medium"

extension UIFont {
    public enum TBFonts {
        case title, headline, body, subtext, caption, label

        static func allFonts() -> [TBFonts] {
            return [.title, .headline, .body, .subtext, .caption, .label]
        }

        static var registredFonts: [(RegisterFontError?, String)] = {
            let fontNames = Set(allFonts().map { $0.fontName })
            return fontNames.map { (UIFont.register(fileNameString: $0, type: "ttf"), $0) }
        }()

        var fontName: String {
            switch self {
            case .title: return boldFontName
            case .headline: return boldFontName
            case .body: return regularFontName
            case .subtext: return regularFontName
            case .caption: return regularFontName
            case .label: return mediumFontName
            }
        }

        var fontSize: CGFloat {
            switch self {
            case .title: return 28
            case .headline: return 17
            case .body: return 17
            case .subtext: return 15
            case .caption: return 13
            case .label: return 11
            }
        }

        public func font() -> UIFont {
            _ = TBFonts.registredFonts
            return UIFont.nonNilFont(name: fontName, size: fontSize)
        }

        public func lineSpacing() -> CGFloat {
            return leading() - font().lineHeight
        }

        public func leading() -> CGFloat {
            switch self {
            case .title: return 34
            case .headline: return 22
            case .body: return 22
            case .subtext: return 20
            case .caption: return 18
            case .label: return 18
            }
        }

        public func characterSpacing() -> CGFloat {
            switch self {
            case .title: return 0.36
            case .headline: return -0.41
            case .body: return -0.41
            case .subtext: return -0.24
            case .caption: return -0.08
            case .label: return -0.07
            }
        }
    }
}

private extension UIFont {
    static func nonNilFont(name fontName: String, size fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: fontName, size: fontSize) else {
            fatalError("\(fontName) was not found")
        }
        return font
    }
}
