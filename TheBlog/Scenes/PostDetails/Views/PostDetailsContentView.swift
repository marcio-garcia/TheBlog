//
//  PostDetailsContentView.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Ivorywhite
import Services
import DesignSystem

protocol PostDetailsContentViewProtocol: UIView {
    func updatePost(_ post: Post?)
    func updateComments(comments: Comments)
}

class PostDetailsContentView: UIView {

    // MARK: Layout properties

    private lazy var postHeaderView = { return PostHeaderView() }()
    private lazy var tableView = { return UITableView() }()
    private lazy var activityIndicatorView = { return UIActivityIndicatorView() }()
    private let refreshControl = UIRefreshControl()

    // MARK: Properties

    private weak var viewController: PostDetailsViewController?
    private weak var imageWorker: ImageWorkLogic?
    private var displayedPost: Post?

    private var listingDataSource: ListingDataSource<CommentTableViewCell>?
    private var listingDelegate: ListingDelegate<CommentTableViewCell>?

    // MARK: Object lifecycle
    
    init(viewController: PostDetailsViewController?, imageWorker: ImageWorkLogic?) {
        super.init(frame: CGRect.zero)
        self.viewController = viewController
        self.imageWorker = imageWorker
        tableView.tableHeaderView = postHeaderView

        self.listingDataSource = ListingDataSource(imageWorker: imageWorker)
        self.listingDelegate = ListingDelegate(heightForRow: nil,
                                               didSelectRowHandler: nil,
                                               didScrollHandler: didScroll)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view is meant to be used with view coding")
    }
    
    // MARK: Data
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        viewController?.fetchFirstComments()
    }

    private func buildEmtpyView() -> UIView {
        return PostDetailsEmptyView(messageText: "No comments yet.",
                                      actionTitle: nil,
                                      actionHandler: nil)
    }

    // MARK: Actions

    func postImageTapped(image: UIImage?) {
        viewController?.routeToFullScreenImage(image: image)
    }

    func didScroll() {
        viewController?.fetchNextComments()
    }
}

// MARK: ViewCodingProtocol

extension PostDetailsContentView: ViewCodingProtocol {
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(activityIndicatorView)
    }

    func setupConstraints() {
        tableView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]}

        postHeaderView.constraint {[
            $0.topAnchor.constraint(equalTo: tableView.topAnchor),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor),
            $0.heightAnchor.constraint(equalToConstant: 400)
        ]}


        activityIndicatorView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            $0.widthAnchor.constraint(equalToConstant: 24),
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        ]}
    }

    func configureViews() {

        postHeaderView.backgroundColor = UIColor.TBColors.primary.background
        postHeaderView.imageTapHandler = postImageTapped

        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.TBColors.primary.background
        tableView.refreshControl = refreshControl
        tableView.dataSource = listingDataSource
        tableView.delegate = listingDelegate
        tableView.tableFooterView = UIView()
        tableView.register(CommentTableViewCell.self,
                           forCellReuseIdentifier: CommentTableViewCell.identifier)

        tableView.tableHeaderView?.layoutIfNeeded()
        tableView.tableHeaderView = tableView.tableHeaderView

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        activityIndicatorView.startAnimating()
    }
}

// MARK: PostDetailsContentViewProtocol

extension PostDetailsContentView: PostDetailsContentViewProtocol {
    func updatePost(_ post: Post?) {
        postHeaderView.title = post?.title
        postHeaderView.date = post?.date
        postHeaderView.body = post?.body
        tableView.tableHeaderView = postHeaderView
        guard let urlString = post?.imageURL, let url = URL(string: urlString) else {
            postHeaderView.image = nil
            return
        }
        _ = imageWorker?.download(with: url, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image): self?.postHeaderView.image = image
                case .failure: self?.postHeaderView.image = nil
                }
            }
        })
    }

    func updateComments(comments: Comments) {
        guard let dataSource = listingDataSource else { return }
        let updtedDataList = dataSource.updateDataList(with: comments)
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()

            if updtedDataList.isEmpty {
                self.tableView.backgroundView = self.buildEmtpyView()
            } else {
                if !comments.isEmpty {
                    self.tableView.reloadData()
                }
            }
            self.listingDelegate?.endFetching()
        }
    }
}
