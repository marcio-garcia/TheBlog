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

    // MARK: Object lifecycle
    
    init(viewController: AuthorsListViewController?, imageWorker: ImageWorkLogic?) {
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
        tableView.dataSource = self
        tableView.delegate = self
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

    // MARK: Pagination

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard prefetchingAuthors == false else { return }
        let actualPosition: CGFloat = scrollView.contentOffset.y
        let contentHeight: CGFloat = scrollView.contentSize.height - (scrollView.frame.size.height)
        if (actualPosition >= contentHeight) {
            DispatchQueue.global().async {
                self.prefetchingAuthors = true
                self.viewController?.fetchNextAuthors()
            }
         }
    }
}

// MARK: AuthorsListContentViewProtocol

extension AuthorsListContentView: AuthorsListContentViewProtocol {
    func updateAuthors(displayedAuthors: Authors) {
        self.displayedAuthors.append(contentsOf: displayedAuthors)
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
            self.prefetchingAuthors = false
        }
    }
}

// MARK: UITableViewDataSource

extension AuthorsListContentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedAuthors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AuthorsListTableViewCell.identifier,
                                                    for: indexPath) as? AuthorsListTableViewCell {

            cell.configure(imageWorker: imageWorker, author: displayedAuthors[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}

// MARK: UITableViewDelegate

extension AuthorsListContentView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? AuthorsListTableViewCell {
            let selectedAuthor = cell.selectedAuthor()
            viewController?.selectedAurhor(selectedAuthor)
        }
    }
}
