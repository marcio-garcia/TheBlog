import UIKit

extension UIColor {

    public enum TBColors {

        public enum primary {
            public static var background: UIColor {
                return UIColor.white
            }

            public static var text: UIColor {
                return UIColor.gray
            }

            public static var avatarText: UIColor {
                return UIColor.darkGray
            }

            public static var avatarBorder: UIColor {
                return UIColor.darkGray
            }

            public static var avatarBackground: UIColor {
                return UIColor.lightGray
            }

            public static var postImagePlaceholder: UIColor {
                return UIColor(red: 217 / 255,
                               green: 217 / 255,
                               blue: 217 / 255,
                               alpha: 1)
            }

            public static var buttonTitle: UIColor {
                return UIColor.blue
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

            public static var avatarText: UIColor {
                return UIColor.white
            }

            public static var avatarBorder: UIColor {
                return UIColor.white
            }

            public static var avatarBackground: UIColor {
                return UIColor.lightGray
            }

            public static var postImagePlaceholder: UIColor {
                return UIColor(red: 217 / 255,
                               green: 217 / 255,
                               blue: 217 / 255,
                               alpha: 1)
            }

            public static var buttonTitle: UIColor {
                return UIColor.white
            }
        }

    }
}
