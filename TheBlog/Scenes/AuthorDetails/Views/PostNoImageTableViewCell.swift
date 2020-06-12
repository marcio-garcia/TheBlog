//
//  PostNoImageTableViewCell.swift
//  TheBlog
//
//  Created by Marcio Garcia on 12/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Services

class PostNoImageTableViewCell: UITableViewCell {

    static let identifier = String(describing: PostNoImageTableViewCell.self)

    // MARK: Layout properties

    private lazy var stackView = { UIStackView() }()
    private lazy var titleLabel = { UILabel() }()
    private lazy var dateLabel = { UILabel() }()
    private lazy var timeLabel = { UILabel() }()
    private lazy var bodyLabel = { UILabel() }()

    // MARK: properties

    public weak var imageWorker: ImageWorkLogic?
    private var requestId: RequestId?

    // MARK: Object lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("This view should implemented with view coding")
    }

    // MARK: Data

    override func prepareForReuse() {
        if let requestId = self.requestId {
            imageWorker?.cancelDownload(requestId: requestId)
            self.requestId = nil
        }
        titleLabel.text = nil
        dateLabel.text = nil
        timeLabel.text = nil
        bodyLabel.text = nil
    }

    func configure(imageWorker: ImageWorkLogic?, displayedPost: DisplayedPost) {
        dateLabel.text = nil
        timeLabel.text = nil
        if let postDate = Date.date(from: displayedPost.post.date, format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") {
            dateLabel.text = Date.string(from: postDate, format: "dd MMM yyyy")
            timeLabel.text = Date.string(from: postDate, format: "HH:mm")
        }
        titleLabel.text = displayedPost.post.title
        bodyLabel.text = displayedPost.post.body
        if let imageWorker = imageWorker {
            self.imageWorker = imageWorker
        }
    }
}

// MARK: ViewCodingProtocol

extension PostNoImageTableViewCell: ViewCodingProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
    }

    func setupConstraints() {
        dateLabel.constraint {[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            $0.widthAnchor.constraint(equalToConstant: 48)
        ]}

        timeLabel.constraint {[
            $0.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3),
            $0.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
        ]}

        stackView.constraint {[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            $0.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8),
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]}
    }

    func configureViews() {
        dateLabel.font = UIFont.TBFonts.body.font()
        dateLabel.textColor = UIColor.TBColors.primary.text
        dateLabel.numberOfLines = 3

        timeLabel.font = UIFont.TBFonts.caption.font()
        timeLabel.textColor = UIColor.TBColors.primary.text
        timeLabel.numberOfLines = 1

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill

        titleLabel.font = UIFont.TBFonts.body.font()
        titleLabel.textColor = UIColor.TBColors.primary.text

        bodyLabel.font = UIFont.TBFonts.caption.font()
        bodyLabel.textColor = UIColor.TBColors.primary.text
        bodyLabel.numberOfLines = 0
    }
}
