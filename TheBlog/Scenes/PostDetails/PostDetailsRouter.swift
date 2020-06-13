//
//  PostDetailsRouter.swift
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

protocol PostDetailsRoutingLogic {
    var dataStore: PostDetailsDataStore? { get }
    func routeToFullScreenImage(imageUrl: String?, image: UIImage?, imageWorker: ImageWorkLogic?)
}

protocol PostDetailsDataPassing {
    var dataStore: PostDetailsDataStore? { get }
}

class PostDetailsRouter: PostDetailsRoutingLogic, PostDetailsDataPassing {

    weak var viewController: PostDetailsViewController?
    var dataStore: PostDetailsDataStore?

    init(dataStore: PostDetailsDataStore?) {
        self.dataStore = dataStore
    }

    func routeToFullScreenImage(imageUrl: String?, image: UIImage?, imageWorker: ImageWorkLogic?) {
        let vc = FullImageViewController(imageUrl: nil, image: image, imageWorker: imageWorker)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}