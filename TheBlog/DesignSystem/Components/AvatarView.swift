//
//  AvatarView.swift
//  TheBlog
//
//  Created by Marcio Garcia on 11/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit

class AvatarView: UIView {

    private lazy var avatarImageView = { return UIImageView() }()
    private lazy var noImageView = { return UIView() }()
    private lazy var initialsLabel = { return UILabel() }()

    public var name: String {
        didSet {
            let text = name.removeNameTitle()
            initialsLabel.text = text.initials()
            updateUI()
        }
    }

    public var image: UIImage? {
        didSet {
            avatarImageView.image = image
            updateUI()
        }
    }

    init() {
        self.name = ""
        super.init(frame: CGRect.zero)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("This view should be implemented with view coding")
    }

    private func updateUI() {
        if avatarImageView.image == nil {
            avatarImageView.isHidden = true
        } else {
            avatarImageView.isHidden = false
        }
    }
}

extension AvatarView: ViewCodingProtocol {
    func buildViewHierarchy() {
        addSubview(noImageView)
        addSubview(initialsLabel)
        addSubview(avatarImageView)
    }

    func setupConstraints() {
        noImageView.constraint(to: self)
        initialsLabel.constraint(to: self)
        avatarImageView.constraint(to: self)
    }

    func configureViews() {
        self.layer.borderColor = UIColor.TBColors.primary.avatarBorder.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true

        noImageView.backgroundColor = UIColor.TBColors.primary.avatarBackground
        noImageView.clipsToBounds = true

        initialsLabel.font = UIFont.TBFonts.title.font()
        initialsLabel.textColor = UIColor.TBColors.primary.avatarText
        initialsLabel.textAlignment = .center
    }
}
