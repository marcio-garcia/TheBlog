//
//  AuthorsListTableViewCell.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Services

class AuthorsListTableViewCell: UITableViewCell {

    static let identifier = String(describing: AuthorsListTableViewCell.self)
    
    // MARK: Layout properties
    
    private lazy var authorTitleView = { return AuthorTitleView() }()
    
    // MARK: properties
    
    public weak var imageWorker: ImageWorkLogic?
    private var requestId: RequestId?
    private var author: Author?
    
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
        authorTitleView.image = nil
        authorTitleView.name = nil
    }
    
    func configure(imageWorker: ImageWorkLogic?, author: Author) {
        self.author = author
        self.authorTitleView.name = author.name
        if let imageWorker = imageWorker {
            self.imageWorker = imageWorker
        }
        if let url = URL(string: author.avatarURL) {
            self.requestId = self.imageWorker?.download(with: url, completion: { image in
                DispatchQueue.main.async {
                    self.authorTitleView.image = image
                }
            })
        }
    }

    func selectedAuthor() -> Author? {
        return author
    }
}

// MARK: ViewCodingProtocol

extension AuthorsListTableViewCell: ViewCodingProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(authorTitleView)
    }
    
    func setupConstraints() {
        authorTitleView.constraint {[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]}
    }
}
