//
//  AuthorDetailsContentView.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Ivorywhite
import Services

protocol AuthorDetailsContentViewProtocol: UIView {
    func updateAuthor(author: Author?)
    func updatePosts(displayedPosts: [DisplayedPost])
}

class AuthorDetailsContentView: UIView, ViewCodingProtocol {

    // MARK: Layout properties

    private lazy var authorHeaderView = { AuthorHeaderView() }()
    private lazy var tableView = { return UITableView() }()
    private lazy var activityIndicatorView = { return UIActivityIndicatorView() }()
    private let refreshControl = UIRefreshControl()

    // MARK: Properties

    private weak var viewController: AuthorDetailsViewController?
    private var displayedAuthor: Author?
    private var displayedPosts: [DisplayedPost] = []
    private weak var imageWorker: ImageWorkLogic?

    // MARK: Object lifecycle
    
    init(viewController: AuthorDetailsViewController?, imageWorker: ImageWorkLogic?) {
        super.init(frame: CGRect.zero)
        self.viewController = viewController
        self.imageWorker = imageWorker
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view is meant to be used with view coding")
    }
    
    // MARK: ViewCodingProtocol
    
    func buildViewHierarchy() {
        addSubview(authorHeaderView)
        addSubview(tableView)
        addSubview(activityIndicatorView)
    }
    
    func setupConstraints() {
        authorHeaderView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor),
            $0.heightAnchor.constraint(equalToConstant: 100.0)
        ]}

        tableView.constraint {[
            $0.topAnchor.constraint(equalTo: authorHeaderView.bottomAnchor),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]}

        activityIndicatorView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            $0.widthAnchor.constraint(equalToConstant: 24),
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        ]}
    }
    
    func configureViews() {

        authorHeaderView.backgroundColor = UIColor.TBColors.primary.background

        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.TBColors.primary.background
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(PostWithImageTableViewCell.self,
                           forCellReuseIdentifier: PostWithImageTableViewCell.identifier)
        tableView.register(PostNoImageTableViewCell.self,
                           forCellReuseIdentifier: PostNoImageTableViewCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        activityIndicatorView.startAnimating()
    }
    
    // MARK: Data
    
    @objc func refreshData(_ sender: UIRefreshControl) {
    }

    private func buildEmtpyView() -> UIView {
        AuthorDetailsEmptyView(messageText: "Sorry, no posts found.", actionTitle: "Retry") { sender in
            //self?.viewController?.fetchFirstAuthors()
        }
    }
}

// MARK: AuthorDetailsContentViewProtocol

extension AuthorDetailsContentView: AuthorDetailsContentViewProtocol {
    func updateAuthor(author: Author?) {
        authorHeaderView.name = author?.name
        authorHeaderView.email = author?.email
        authorHeaderView.userName = author?.userName
        guard let urlString = author?.avatarURL, let url = URL(string: urlString) else {
            authorHeaderView.image = nil
            return
        }
        _ = imageWorker?.download(with: url, completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.authorHeaderView.image = image
            }
        })
    }

    func updatePosts(displayedPosts: [DisplayedPost]) {
        self.displayedPosts.append(contentsOf: displayedPosts)
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()

            if self.displayedPosts.isEmpty {
                self.tableView.backgroundView = self.buildEmtpyView()
            } else {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: UITableViewDataSource

extension AuthorDetailsContentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let displayedPost = displayedPosts[indexPath.row]
        if displayedPost.hasImage {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostWithImageTableViewCell.identifier,
                                                        for: indexPath) as? PostWithImageTableViewCell {

                cell.configure(imageWorker: imageWorker, displayedPost: displayedPost)
                cell.updateTableLayout = {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostNoImageTableViewCell.identifier,
                                                        for: indexPath) as? PostNoImageTableViewCell {

                cell.configure(imageWorker: imageWorker, displayedPost: displayedPost)
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: UITableViewDelegate

extension AuthorDetailsContentView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == displayedPosts.count - 20 {
            DispatchQueue.global().async {

            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
