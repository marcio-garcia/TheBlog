//
//  PostDetailsBuilder.swift
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

class PostDetailsBuilder {

    private var service: BlogApi
    
    init(service: BlogApi) {
        self.service = service
    }
    
    func build(imageCache: NSCache<NSString, UIImage>) -> PostDetailsViewController {
        let netServiceForImageDownloading = Ivorywhite.shared.service(debugMode: false)
        let imageWorker = ImageWorker(service: netServiceForImageDownloading,
                                      imageCache: imageCache)
        let presenter = PostDetailsPresenter()
        let worker = PostDetailsWorker(service: service)
        let interactor = PostDetailsInteractor(presenter: presenter, worker: worker)
        let router = PostDetailsRouter(dataStore: interactor)
        let viewController = PostDetailsViewController(interactor: interactor,
                                                       router: router,
                                                       imageWorker: imageWorker)
        router.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
