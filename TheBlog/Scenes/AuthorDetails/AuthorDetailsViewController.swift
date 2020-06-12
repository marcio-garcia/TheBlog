//
//  AuthorDetailsViewController.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright (c) 2020 Oxl Tech. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Services

protocol AuthorDetailsDisplayLogic: class {
    func displayAuthor(_ author: Author?)
    func displayPosts(_ displayedPosts: [DisplayedPost])
    func displayError(title: String, message: String)
}

class AuthorDetailsViewController: UIViewController, AuthorDetailsDisplayLogic {
    
    // MARK: Layout properties
    
    var contentView: AuthorDetailsContentViewProtocol?
    
    // MARK: Properties
    
    var interactor: AuthorDetailsBusinessLogic?
    var router: AuthorDetailsRoutingLogic?
    private var imageWorker: ImageWorkLogic?

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
  
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    convenience init(interactor: AuthorDetailsBusinessLogic?,
                     router: AuthorDetailsRoutingLogic?,
                     imageWorker: ImageWorkLogic?) {
        self.init(nibName: nil, bundle: nil)
        self.interactor = interactor
        self.router = router
        self.imageWorker = imageWorker
        contentView = AuthorDetailsContentView(viewController: self, imageWorker: self.imageWorker)
        setupViewConfiguration()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Posts"
        fetchAuthor()
        fetchFirstPosts()
    }
  
    // MARK: Fetch data

    func fetchAuthor() {
        interactor?.fetchAuthor()
    }

    func fetchFirstPosts() {
        interactor?.fetchFirstPosts()
    }

    func fetchNextPosts() {
        interactor?.fetchNextPosts()
    }

    // MARK: AuthorDetailsDisplayLogic

    func displayAuthor(_ author: Author?) {
        contentView?.updateAuthor(author: author)
    }

    func displayPosts(_ displayedPosts: [DisplayedPost]) {
        contentView?.updatePosts(displayedPosts: displayedPosts)
    }

    func displayError(title: String, message: String) {
        contentView?.updatePosts(displayedPosts: [])
        DispatchQueue.main.async {
            let alert = UIAlertController.standardMessage(title: title,
                                                          message: message,
                                                          completion: nil)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension AuthorDetailsViewController: ViewCodingProtocol {
    func buildViewHierarchy() {
        guard let contentView = contentView else { return }
        view.addSubview(contentView)
    }
    
    func setupConstraints() {
        contentView?.constraint {[
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ]}
    }
}