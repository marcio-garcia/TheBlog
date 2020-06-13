//
//  PostTableViewCell.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Services
import DesignSystem

class PostTableViewCell: UITableViewCell {

    static let identifier = String(describing: PostTableViewCell.self)
    
    // MARK: Layout properties

    private lazy var dateStackView = { UIStackView() }()
    private lazy var bodyStackView = { UIStackView() }()
    private lazy var titleLabel = { UILabel() }()
    private lazy var dateLabel = { UILabel() }()
    private lazy var timeLabel = { UILabel() }()
    private lazy var bodyLabel = { UILabel() }()
    private lazy var postImageView = { UIImageView() }()

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
        postImageView.isHidden = false
        postImageView.image = UIImage(named: "image-placeholder")
    }
    
    func configure(imageWorker: ImageWorkLogic?, displayedPost: DisplayedPost) {

        if let postDate = Date.date(from: displayedPost.post.date, format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") {
            dateLabel.text = Date.string(from: postDate, format: "dd MMM yyyy")
            timeLabel.text = Date.string(from: postDate, format: "HH:mm")
        }
        titleLabel.text = displayedPost.post.title
        bodyLabel.text = displayedPost.post.body
        if let imageWorker = imageWorker {
            self.imageWorker = imageWorker
        }
        if let url = URL(string: displayedPost.post.imageURL), displayedPost.hasImage {
            self.requestId = self.imageWorker?.download(with: url, completion: { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self.postImageView.image = image
                    case .failure:
                        break
                    }
                }
            })
        }
    }
}

// MARK: ViewCodingProtocol

extension PostTableViewCell: ViewCodingProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(dateStackView)
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(timeLabel)
        dateStackView.addArrangedSubview(UIView())
        contentView.addSubview(bodyStackView)
        bodyStackView.addArrangedSubview(titleLabel)
        bodyStackView.addArrangedSubview(bodyLabel)
        bodyStackView.addArrangedSubview(postImageView)
    }
    
    func setupConstraints() {
        dateStackView.constraint {[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            $0.widthAnchor.constraint(equalToConstant: 48)
        ]}
        dateLabel.constraint {[
            $0.heightAnchor.constraint(equalToConstant: 70)
        ]}
        timeLabel.constraint {[
            $0.heightAnchor.constraint(equalToConstant: 20)
        ]}

        bodyStackView.constraint {[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            $0.leadingAnchor.constraint(equalTo: dateStackView.trailingAnchor, constant: 8),
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]}
        postImageView.constraint {[
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        ]}

    }

    func configureViews() {
        dateStackView.axis = .vertical
        dateStackView.alignment = .leading
        dateStackView.distribution = .fill

        dateLabel.font = UIFont.TBFonts.body.font()
        dateLabel.textColor = UIColor.TBColors.primary.text
        dateLabel.numberOfLines = 3

        timeLabel.font = UIFont.TBFonts.caption.font()
        timeLabel.textColor = UIColor.TBColors.primary.text
        timeLabel.numberOfLines = 1

        bodyStackView.axis = .vertical
        bodyStackView.alignment = .fill
        bodyStackView.distribution = .fill

        titleLabel.font = UIFont.TBFonts.body.font()
        titleLabel.textColor = UIColor.TBColors.primary.text

        bodyLabel.font = UIFont.TBFonts.caption.font()
        bodyLabel.textColor = UIColor.TBColors.primary.text
        bodyLabel.numberOfLines = 0

        postImageView.contentMode = .scaleToFill
        postImageView.clipsToBounds = true
        postImageView.backgroundColor = UIColor.TBColors.primary.postImagePlaceholder
    }
}
