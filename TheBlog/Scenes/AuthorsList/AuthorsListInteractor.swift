//
//  AuthorsListInteractor.swift
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

protocol AuthorsListBusinessLogic {
    func fetchAuthors(request: AuthorsList.FetchAuthors.Request)
}

protocol AuthorsListDataStore {
}

class AuthorsListInteractor: AuthorsListBusinessLogic, AuthorsListDataStore {
  
    var presenter: AuthorsListPresentationLogic?
    var worker: AuthorsListWorkLogic
  
    // MARK: Object lifecycle
    
    init(presenter: AuthorsListPresentationLogic?, worker: AuthorsListWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: Fetch data
  
    func fetchAuthors(request: AuthorsList.FetchAuthors.Request) {
        worker.requestAuthors { [weak self] authors, error in
            if let error = error {
                print("ERROR ******")
                print(error)
            }
            print(authors)
            guard let authors = authors else { return }
            let response = AuthorsList.FetchAuthors.Response(authors: authors)
            self?.presenter?.presentAuthors(response: response)
        }
    }
}
