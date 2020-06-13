//
//  PostHeaderView.swift
//  TheBlog
//
//  Created by Marcio Garcia on 11/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Services

class PostHeaderView: UIView {

    private lazy var titleLabel = { return UILabel() }()
    private lazy var dateLabel = { return UILabel() }()
    private lazy var bodyLabel = { return UILabel() }()
    private lazy var postImageView = { return UIImageView() }()


    public var image: UIImage? {
        get {
            return postImageView.image
        }
        set {
            postImageView.image = newValue
        }
    }

    public var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    public var date: String? {
        get {
            return dateLabel.text
        }
        set {
            dateLabel.text = newValue
        }
    }

    public var body: String? {
        get {
            return bodyLabel.text
        }
        set {
            bodyLabel.text = newValue
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

extension PostHeaderView: ViewCodingProtocol {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(bodyLabel)
        addSubview(postImageView)
    }

    func setupConstraints() {
        titleLabel.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]}

        dateLabel.constraint {[
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            $0.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ]}

        bodyLabel.constraint {[
            $0.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            $0.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ]}

        postImageView.constraint {[
            $0.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 8),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            $0.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ]}
    }

    func configureViews() {
        titleLabel.font = UIFont.TBFonts.body.font()
        titleLabel.textColor = UIColor.TBColors.primary.text

        dateLabel.font = UIFont.TBFonts.caption.font()
        dateLabel.textColor = UIColor.TBColors.primary.text

        bodyLabel.font = UIFont.TBFonts.caption.font()
        bodyLabel.textColor = UIColor.TBColors.primary.text
        bodyLabel.numberOfLines = 0

        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
    }
}
