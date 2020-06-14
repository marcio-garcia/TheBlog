//
//  AuthorsListContentView.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Ivorywhite
import Services
import DesignSystem

protocol AuthorsListContentViewProtocol: UIView {
    func updateAuthors(displayedAuthors: Authors)
}

class AuthorsListContentView: UIView, ViewCodingProtocol {

    // MARK: Layout properties
    
    private lazy var tableView: UITableView = {
        return UITableView()
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
    }()

    private let refreshControl = UIRefreshControl()
    
    // MARK: Properties

    private weak var viewController: AuthorsListViewController?
    private var displayedAuthors: Authors = []
    private weak var imageWorker: ImageWorkLogic?
    private var prefetchingAuthors: Bool = false

    private var listingDataSource: ListingDataSource<AuthorsListTableViewCell>?
    private var listingDelegate: ListingDelegate<AuthorsListTableViewCell>?

    // MARK: Object lifecycle
    
    init(viewController: AuthorsListViewController?, imageWorker: ImageWorkLogic?) {
        super.init(frame: CGRect.zero)

        self.viewController = viewController
        self.imageWorker = imageWorker

        self.listingDataSource = ListingDataSource(imageWorker: imageWorker)
        self.listingDelegate = ListingDelegate(heightForRow: 80.0,
                                               didSelectRowHandler: didSelectRow,
                                               didScrollHandler: didScroll)

        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view is meant to be used with view coding")
    }
    
    // MARK: ViewCodingProtocol
    
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

        activityIndicatorView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            $0.widthAnchor.constraint(equalToConstant: 24),
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        ]}
    }
    
    func configureViews() {
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.TBColors.primary.background
        tableView.refreshControl = refreshControl
        tableView.dataSource = self.listingDataSource
        tableView.delegate = self.listingDelegate
        tableView.register(AuthorsListTableViewCell.self, forCellReuseIdentifier: AuthorsListTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        activityIndicatorView.startAnimating()
    }
    
    // MARK: Data
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        viewController?.fetchFirstAuthors()
    }

    private func buildEmtpyView() -> UIView {
        AuthorsListEmptyView(messageText: "Sorry, no authors found.", actionTitle: "Retry") { [weak self] sender in
            self?.viewController?.fetchFirstAuthors()
        }
    }

    // MARK: Actions

    func didSelectRow(cell: AuthorsListTableViewCell) {
        let selectedAuthor = cell.selectedAuthor()
        viewController?.selectedAurhor(selectedAuthor)
    }

    func didScroll() {
        viewController?.fetchNextAuthors()
    }
}

// MARK: AuthorsListContentViewProtocol

extension AuthorsListContentView: AuthorsListContentViewProtocol {
    func updateAuthors(displayedAuthors: Authors) {
        self.displayedAuthors.append(contentsOf: displayedAuthors)
        self.listingDataSource?.dataList = self.displayedAuthors
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()

            if self.displayedAuthors.isEmpty {
                self.tableView.backgroundView = self.buildEmtpyView()
            } else {
                if !displayedAuthors.isEmpty {
                    self.tableView.reloadData()
                }
            }
            //self.prefetchingAuthors = false
            self.listingDelegate?.endFetching()
        }
    }
}
