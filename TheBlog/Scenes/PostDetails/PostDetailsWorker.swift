//
//  PostDetailsWorker.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright (c) 2020 Oxl Tech. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Services
import Ivorywhite

protocol PostDetailsWorkLogic {
    func requestComments(postId: Int,
                         page: Int,
                         commentsPerPage: Int?,
                         orderBy: CommentsOrderBy?,
                         direction: SortDirection?,
                         completion: @escaping (Comments?, Error?) -> Void)
}

class PostDetailsWorker: PostDetailsWorkLogic {

    var service: BlogApi
    
    // MARK: Object Lifecycle
    
    init(service: BlogApi) {
        self.service = service
    }
    
    // MARK: PostDetailsWorkLogic
    
    func requestComments(postId: Int,
                         page: Int,
                         commentsPerPage: Int?,
                         orderBy: CommentsOrderBy?,
                         direction: SortDirection?,
                         completion: @escaping (Comments?, Error?) -> Void) {
        service.requestComments(postId: postId,
                                page: page,
                                commentsPerPage: commentsPerPage,
                                orderBy: orderBy,
                                direction: direction) { comments, error in
            if let _error = error {
                completion(comments, _error)
            } else {
                completion(comments, error)
            }
        }
    }
}
