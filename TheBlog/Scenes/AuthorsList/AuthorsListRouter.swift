//
//  AuthorsListRouter.swift
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

protocol AuthorsListRoutingLogic {
    func routeToAuthorDetails()
}

protocol AuthorsListDataPassing {
    var dataStore: AuthorsListDataStore? { get }
}

class AuthorsListRouter: AuthorsListRoutingLogic, AuthorsListDataPassing {
    weak var viewController: AuthorsListViewController?
    var dataStore: AuthorsListDataStore?
    var authorDetailsBuilder: AuthorDetailsBuilder

    init(dataStore: AuthorsListDataStore?, authorDetailsBuilder: AuthorDetailsBuilder) {
        self.dataStore = dataStore
        self.authorDetailsBuilder = authorDetailsBuilder
    }
 
    // MARK: Routing
    
    func routeToAuthorDetails() {
        let destinationVC = authorDetailsBuilder.build()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        navigateToSomewhere(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation
    
    func navigateToSomewhere(source: AuthorsListViewController, destination: AuthorDetailsViewController) {
        source.show(destination, sender: nil)
    }
  
    // MARK: Passing data
    
    func passDataToSomewhere(source: AuthorsListDataStore, destination: inout AuthorDetailsDataStore) {
        destination.author = source.selectedAuthor
    }
}
