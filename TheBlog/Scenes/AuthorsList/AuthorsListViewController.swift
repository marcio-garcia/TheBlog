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

protocol AuthorsListDisplayLogic: class {
    func displayAuthors(viewModel: AuthorsList.FetchAuthors.ViewModel)
}

class AuthorsListViewController: UIViewController, AuthorsListDisplayLogic {
    var interactor: AuthorsListBusinessLogic?
    var router: AuthorsListRoutingLogic?

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
  
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    convenience init(interactor: AuthorsListBusinessLogic?, router: AuthorsListRoutingLogic?) {
        self.init(nibName: nil, bundle: nil)
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAuthors()
    }
  
    // MARK: Fetch data
  
    func fetchAuthors() {
        let request = AuthorsList.FetchAuthors.Request()
        interactor?.fetchAuthors(request: request)
    }
  
    // MARK: AuthorsListDisplayLogic
    
    func displayAuthors(viewModel: AuthorsList.FetchAuthors.ViewModel){
    }
}
