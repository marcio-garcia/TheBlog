//
//  AuthorTitleView.swift
//  TheBlog
//
//  Created by Marcio Garcia on 11/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit

class AuthorTitleView: UIView {

    private lazy var avatarView = { return AvatarView() }()
    private lazy var nameLabel = { return UILabel() }()

    public var image: UIImage? {
        get {
            return avatarView.image
        }
        set {
            avatarView.image = newValue
        }
    }

    public var name: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
            avatarView.name = newValue ?? ""
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("This view should be implemented with view coding")
    }
}

extension AuthorTitleView: ViewCodingProtocol {
    func buildViewHierarchy() {
        addSubview(avatarView)
        addSubview(nameLabel)
    }

    func setupConstraints() {
        avatarView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor),
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor)
        ]}

        nameLabel.constraint {[
            $0.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor),
            $0.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor)
        ]}
    }

    func configureViews() {
        nameLabel.font = UIFont.TBFonts.body.font()
        nameLabel.textColor = UIColor.TBColors.primary.text
        nameLabel.textAlignment = .left
    }
}

