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
import DesignSystem

protocol AuthorDetailsContentViewProtocol: UIView {
    func updateAuthor(author: Author?)
    func updatePosts(posts: Posts)
}

class AuthorDetailsContentView: UIView, ViewCodingProtocol {

    // MARK: Layout properties

    private lazy var authorHeaderView = { AuthorHeaderView() }()
    private lazy var tableView = { return UITableView() }()
    private lazy var activityIndicatorView = { return UIActivityIndicatorView() }()
    private let refreshControl = UIRefreshControl()

    // MARK: Properties

    private weak var viewController: AuthorDetailsViewController?
    private weak var imageWorker: ImageWorkLogic?
    private var displayedAuthor: Author?

    private var listingDataSource: ListingDataSource<PostTableViewCell>?
    private var listingDelegate: ListingDelegate<PostTableViewCell>?


    // MARK: Object lifecycle
    
    init(viewController: AuthorDetailsViewController?, imageWorker: ImageWorkLogic?) {
        super.init(frame: CGRect.zero)
        self.viewController = viewController
        self.imageWorker = imageWorker

        self.listingDataSource = ListingDataSource(imageWorker: imageWorker)
        self.listingDelegate = ListingDelegate(heightForRow: nil,
                                               didSelectRowHandler: didSelectRow,
                                               didScrollHandler: didScroll)

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
        tableView.dataSource = listingDataSource
        tableView.delegate = listingDelegate
        tableView.tableFooterView = UIView()
        tableView.register(PostTableViewCell.self,
                           forCellReuseIdentifier: PostTableViewCell.identifier)

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        activityIndicatorView.startAnimating()
    }
    
    // MARK: Data
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        viewController?.fetchFirstPosts()
    }

    private func buildEmtpyView() -> UIView {
        return AuthorDetailsEmptyView(messageText: "No posts yet.",
                                      actionTitle: nil,
                                      actionHandler: nil)
    }

    // MARK: Actions

    func didSelectRow(cell: PostTableViewCell) {
        viewController?.selectedPost(cell.selected())
    }

    func didScroll() {
        viewController?.fetchNextPosts()
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
        _ = imageWorker?.download(with: url, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image): self?.authorHeaderView.image = image
                case .failure: self?.authorHeaderView.image = nil
                }
            }
        })
    }

    func updatePosts(posts: Posts) {
        guard let dataSource = listingDataSource else { return }
        let updatedDataList = dataSource.updateDataList(with: posts)
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()

            if updatedDataList.isEmpty {
                self.tableView.backgroundView = self.buildEmtpyView()
            } else {
                if !posts.isEmpty {
                    self.tableView.reloadData()
                }
            }
            self.listingDelegate?.endFetching()
        }
    }
}
