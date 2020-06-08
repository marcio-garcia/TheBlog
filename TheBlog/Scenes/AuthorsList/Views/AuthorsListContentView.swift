//
//  AuthorsListContentView.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Ivorywhite

class AuthorsListContentView: UIView, ViewCodingProtocol {

    // MARK: Layout properties
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: Properties

    private weak var viewController: AuthorsListViewController?
    private var displayedAuthors: [AuthorsList.DisplayedAuthor] = []
    
    // MARK: Object lifecycle
    
    init(viewController: AuthorsListViewController?) {
        super.init(frame: CGRect.zero)
        self.viewController = viewController
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view is not meant to be used in xib files")
    }
    
    // MARK: ViewCodingProtocol
    
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]}
    }
    
    func configureViews() {
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AuthorsListTableViewCell.self, forCellReuseIdentifier: AuthorsListTableViewCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    // MARK: Data
    
    func updateAuthors(displayedAuthors: [AuthorsList.DisplayedAuthor]) {
        self.displayedAuthors.append(contentsOf: displayedAuthors)
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        viewController?.fetchFirstAuthors()
    }
}

extension AuthorsListContentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedAuthors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AuthorsListTableViewCell.identifier,
                                                    for: indexPath) as? AuthorsListTableViewCell {
            
            var imageWorker: ImageWorkLogic?
            if cell.imageWorker == nil {
                let service = Ivorywhite.shared.service(debugMode: true)
                imageWorker = ImageWorker(service: service)
            }
            
            cell.configure(imageWorker: imageWorker, author: displayedAuthors[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension AuthorsListContentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
