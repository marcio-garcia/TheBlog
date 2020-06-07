//
//  AuthorsListContentView.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit

class AuthorsListContentView: UIView, ViewCodingProtocol {

    // MARK: Layout properties
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    // MARK: Properties

    private var displayedAuthors: [AuthorsList.DisplayedAuthor] = []
    
    // MARK: Object lifecycle
    
    init() {
        super.init(frame: CGRect.zero)
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
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: Data
    
    func updateAuthors(displayedAuthors: [AuthorsList.DisplayedAuthor]) {
        self.displayedAuthors.append(contentsOf: displayedAuthors)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension AuthorsListContentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedAuthors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension AuthorsListContentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
