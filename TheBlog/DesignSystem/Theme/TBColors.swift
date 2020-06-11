import UIKit

extension UIColor {

    public enum TBColors {

        public enum primary {
            public static var background: UIColor {
                return UIColor.white
            }

            public static var text: UIColor {
                return UIColor(red: 221 / 255,
                               green: 221 / 255,
                               blue: 221 / 255,
                               alpha: 1)
            }

            public static var avatarBorder: UIColor {
                return UIColor.darkGray
            }

            public static var avatarBackground: UIColor {
                return UIColor.gray
            }
        }

        public enum secondary {
            public static var background: UIColor {
                return UIColor.black
            }

            public static var text: UIColor {
                return UIColor(red: 248 / 255,
                green: 248 / 255,
                blue: 248 / 255,
                alpha: 1)
            }

            public static var avatarBorder: UIColor {
                return UIColor.white
            }

            public static var avatarBackground: UIColor {
                return UIColor.lightGray
            }
        }

    }
}
