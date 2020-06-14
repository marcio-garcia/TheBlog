//
//  UIAlertController+Standard.swift
//  TheBlog
//
//  Created by Marcio Garcia on 09/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit

extension UIAlertController {

    static func standardMessage(title: String, message: String, completion: (() -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: completion)
        }))
        return alert
    }
}
