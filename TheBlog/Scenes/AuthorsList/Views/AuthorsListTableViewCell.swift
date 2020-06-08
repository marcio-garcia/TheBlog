//
//  AuthorsListTableViewCell.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit

class AuthorsListTableViewCell: UITableViewCell {

    static let identifier = String(describing: AuthorsListTableViewCell.self)
    
    // MARK: Layout properties
    
    private lazy var avatarImageView: UIImageView = {
        return UIImageView()
    }()
    
    private lazy var nameLabel: UILabel = {
        return UILabel()
    }()
    
    // MARK: properties
    
    public weak var imageWorker: ImageWorkLogic?
    private var requestId: RequestId?
    
    // MARK: Object lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("This view should not be in a xib file or storyboard")
    }

    // MARK: Data
    
    override func prepareForReuse() {
        if let requestId = self.requestId {
            imageWorker?.cancelDownload(requestId: requestId)
            self.requestId = nil
        }
        avatarImageView.image = nil
        nameLabel.text = nil
    }
    
    func configure(imageWorker: ImageWorkLogic?, author: AuthorsList.DisplayedAuthor) {
        self.nameLabel.text = author.name
        if let imageWorker = imageWorker {
            self.imageWorker = imageWorker
        }
        if let url = URL(string: author.avatarUrl) {
            self.requestId = self.imageWorker?.download(with: url, completion: { image in
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            })
        }
    }
}

// MARK: ViewCodingProtocol

extension AuthorsListTableViewCell: ViewCodingProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        avatarImageView.constraint {[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor)
        ]}
        
        nameLabel.constraint {[
            $0.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            $0.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ]}
    }
    
    func configureViews() {
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
    }
    
}
