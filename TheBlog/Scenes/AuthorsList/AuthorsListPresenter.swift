//
//  AuthorsListPresenter.swift
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

protocol AuthorsListPresentationLogic {
    func presentAuthors(response: AuthorsList.FetchAuthors.Response)
    func presentError(response: AuthorsList.Error.Response)
}

class AuthorsListPresenter: AuthorsListPresentationLogic {
    weak var viewController: AuthorsListDisplayLogic?
  
    // MARK: AuthorsListPresentationLogic
  
    func presentAuthors(response: AuthorsList.FetchAuthors.Response) {
        
        let displayedAuthors = response.authors.compactMap {
            AuthorsList.DisplayedAuthor(id: $0.id, name: $0.name, avatarUrl: $0.avatarURL)
        }
        let viewModel = AuthorsList.FetchAuthors.ViewModel(displayedAuthors: displayedAuthors)
        viewController?.displayAuthors(viewModel: viewModel)
    }

    func presentError(response: AuthorsList.Error.Response) {
        let viewModel = AuthorsList.Error.ViewModel(title: "Error",
                                                    message: response.message)
        viewController?.displayError(viewModel: viewModel)
    }
}
