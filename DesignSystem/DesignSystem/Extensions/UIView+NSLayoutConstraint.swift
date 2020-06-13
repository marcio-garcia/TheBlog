//
//  UIView+NSLayoutConstraint.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit

public extension UIView {
    func constraint(_ closure: (UIView) -> [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(closure(self))
    }

    func constraint(to container: UIView, margin: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin),
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

