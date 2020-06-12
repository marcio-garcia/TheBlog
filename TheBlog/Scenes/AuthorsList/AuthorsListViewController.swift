//
//  AuthorsListViewController.swift
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

protocol AuthorsListDisplayLogic: class {
    func displayAuthors(_ authors: Authors)
    func displayError(title: String, message: String)
}

class AuthorsListViewController: UIViewController, AuthorsListDisplayLogic {
    
    // MARK: Layout properties
    
    var contentView: AuthorsListContentViewProtocol?
    
    // MARK: Properties
    
    var interactor: AuthorsListBusinessLogic?
    var router: AuthorsListRoutingLogic?
    private var imageWorker: ImageWorkLogic?

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
  
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    convenience init(interactor: AuthorsListBusinessLogic?,
                     router: AuthorsListRoutingLogic?,
                     imageWorker: ImageWorkLogic?) {
        self.init(nibName: nil, bundle: nil)
        self.interactor = interactor
        self.router = router
        self.imageWorker = imageWorker
        contentView = AuthorsListContentView(viewController: self, imageWorker: self.imageWorker)
        setupViewConfiguration()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Authors"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        fetchFirstAuthors()
    }
  
    // MARK: Fetch data
  
    func fetchFirstAuthors() {
        interactor?.fetchFirstAuthors()
    }
    
    func fetchNextAuthors() {
        interactor?.fetchNextAuthors()
    }

    func selectedAurhor(_ author: Author?) {
        interactor?.selectAuthor(author)
        router?.routeToAuthorDetails()
    }

    // MARK: AuthorsListDisplayLogic
    
    func displayAuthors(_ authors: Authors) {
        contentView?.updateAuthors(displayedAuthors: authors)
    }

    func displayError(title: String, message: String) {
        contentView?.updateAuthors(displayedAuthors: [])
        DispatchQueue.main.async {
            let alert = UIAlertController.standardMessage(title: title,
                                                          message: message,
                                                          completion: nil)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension AuthorsListViewController: ViewCodingProtocol {
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
