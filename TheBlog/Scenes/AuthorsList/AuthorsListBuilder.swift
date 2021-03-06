//
//  AuthorsListBuilder.swift
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
import Ivorywhite

class AuthorsListBuilder {

    private var service: BlogApi
    
    init(service: BlogApi) {
        self.service = service
    }
    
    func build(imageCache: NSCache<NSString, UIImage>) -> AuthorsListViewController {
        let netServiceForImageDownloading = Ivorywhite.shared.service(debugMode: false)
        let imageWorker = ImageWorker(service: netServiceForImageDownloading,
                                      imageCache: imageCache)
        let presenter = AuthorsListPresenter()
        let worker = AuthorsListWorker(service: service)
        let interactor = AuthorsListInteractor(presenter: presenter, worker: worker)
        let router = AuthorsListRouter(dataStore: interactor,
                                       authorDetailsBuilder: AuthorDetailsBuilder(service: service),
                                       imageCache: imageCache)
        let viewController = AuthorsListViewController(interactor: interactor,
                                                       router: router,
                                                       imageWorker: imageWorker)
        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
