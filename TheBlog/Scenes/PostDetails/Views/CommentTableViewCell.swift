//
//  CommentTableViewCell.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Services

class CommentTableViewCell: UITableViewCell {

    static let identifier = String(describing: CommentTableViewCell.self)
    
    // MARK: Layout properties

    private lazy var userStackView = { UIStackView() }()
    private lazy var bodyStackView = { UIStackView() }()
    private lazy var avatarView = { AvatarView() }()
    private lazy var userNameLabel = { UILabel() }()
    private lazy var dateLabel = { UILabel() }()
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
        userNameLabel.text = nil
        dateLabel.text = nil
        bodyLabel.text = nil
        avatarView.image = nil
    }
    
    func configure(imageWorker: ImageWorkLogic?, displayedComment: Comment) {

        dateLabel.text = nil
        if let commentDate = Date.date(from: displayedComment.date,
                                       format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") {

            dateLabel.text = Date.string(from: commentDate, format: "dd MMMM yyyy HH:mm")
        }
        userNameLabel.text = displayedComment.userName
        bodyLabel.text = displayedComment.body
        if let imageWorker = imageWorker {
            self.imageWorker = imageWorker
        }
        if let url = URL(string: displayedComment.avatarURL) {
            self.requestId = self.imageWorker?.download(with: url, completion: { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self.avatarView.image = image
                    case .failure:
                        break
                    }
                }
            })
        }
    }
}

// MARK: ViewCodingProtocol

extension CommentTableViewCell: ViewCodingProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(userStackView)
        userStackView.addArrangedSubview(avatarView)
        userStackView.addArrangedSubview(userNameLabel)
        userStackView.addArrangedSubview(UIView())
        contentView.addSubview(bodyStackView)
        bodyStackView.addArrangedSubview(dateLabel)
        bodyStackView.addArrangedSubview(bodyLabel)
        bodyStackView.addArrangedSubview(UIView())
    }
    
    func setupConstraints() {
        userStackView.constraint {[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            $0.widthAnchor.constraint(equalToConstant: 48)
        ]}
//        dateLabel.constraint {[
//            $0.heightAnchor.constraint(equalToConstant: 70)
//        ]}

        bodyStackView.constraint {[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            $0.leadingAnchor.constraint(equalTo: userStackView.trailingAnchor, constant: 8),
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]}
        avatarView.constraint {[
            $0.widthAnchor.constraint(equalToConstant: 48),
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        ]}

    }

    func configureViews() {
        userStackView.axis = .vertical
        userStackView.alignment = .leading
        userStackView.distribution = .fill

        avatarView.contentMode = .scaleToFill
        avatarView.clipsToBounds = true

        userNameLabel.font = UIFont.TBFonts.body.font()
        userNameLabel.textColor = UIColor.TBColors.primary.text

        bodyStackView.axis = .vertical
        bodyStackView.alignment = .fill
        bodyStackView.distribution = .fill

        dateLabel.font = UIFont.TBFonts.body.font()
        dateLabel.textColor = UIColor.TBColors.primary.text
        dateLabel.numberOfLines = 3

        bodyLabel.font = UIFont.TBFonts.caption.font()
        bodyLabel.textColor = UIColor.TBColors.primary.text
        bodyLabel.numberOfLines = 0
    }
}
