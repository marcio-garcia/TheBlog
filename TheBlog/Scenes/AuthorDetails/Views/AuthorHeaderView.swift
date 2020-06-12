//
//  AuthorHeaderView.swift
//  TheBlog
//
//  Created by Marcio Garcia on 11/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Services

class AuthorHeaderView: UIView {

    private lazy var authorTitleView = { return AuthorTitleView() }()
    private lazy var userNameLabel = { return UILabel() }()
    private lazy var emailLabel = { return UILabel() }()

    public var image: UIImage? {
        get {
            return authorTitleView.image
        }
        set {
            authorTitleView.image = newValue
        }
    }

    public var name: String? {
        get {
            return authorTitleView.name
        }
        set {
            authorTitleView.name = newValue
        }
    }

    public var email: String? {
        get {
            return emailLabel.text
        }
        set {
            emailLabel.text = newValue
        }
    }

    public var userName: String? {
        get {
            return userNameLabel.text
        }
        set {
            userNameLabel.text = newValue
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("This view should me implemented with view coding")
    }
}

extension AuthorHeaderView: ViewCodingProtocol {
    func buildViewHierarchy() {
        addSubview(authorTitleView)
        addSubview(emailLabel)
        addSubview(userNameLabel)
    }

    func setupConstraints() {
        authorTitleView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            $0.heightAnchor.constraint(equalToConstant: 40)
        ]}

        emailLabel.constraint {[
            $0.topAnchor.constraint(equalTo: authorTitleView.bottomAnchor, constant: 8),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
        ]}

        userNameLabel.constraint {[
            $0.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 0),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
        ]}
    }

    func configureViews() {
        emailLabel.font = UIFont.TBFonts.caption.font()
        emailLabel.textColor = UIColor.TBColors.primary.text
        userNameLabel.font = UIFont.TBFonts.caption.font()
        userNameLabel.textColor = UIColor.TBColors.primary.text
    }
}
