//
//  BlogService.swift
//  Services
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Ivorywhite

class BlogService: BlogApi {

    var apiConfiguration: ApiConfiguration
    var service: NetworkService

    init(apiConfiguration: ApiConfiguration, service: NetworkService) {
        self.apiConfiguration = apiConfiguration
        self.service = service
    }

    func cancel(taskId: TaskId) {
        service.cancel(taskId: taskId)
    }

    @discardableResult
    func requestAuthors(page: Int, authorsPerPage: Int?, completion: @escaping (Authors?, Error?) -> Void) -> TaskId? {
        
        guard let request = AuthorsRequest(apiConfiguration: apiConfiguration,
                                           page: page,
                                           authorsPerPage: authorsPerPage) else {
            completion(nil, NetworkError.error(999, "Error constructing the AuthorsRequest"))
            return nil
        }
        
        let requestId = performRequest(request: request, completion: completion)
        return requestId
    }

    @discardableResult
    func requestPosts(authorId: Int,
                      page: Int,
                      postsPerPage: Int?,
                      orderBy: PostsOrderBy?,
                      direction: SortDirection?,
                      completion: @escaping (Posts?, Error?) -> Void) -> TaskId? {

        guard let request = PostsRequest(apiConfiguration: apiConfiguration,
                                         authorId: authorId,
                                         page: page,
                                         postsPerPage: postsPerPage,
                                         orderBy: orderBy,
                                         direction: direction) else {
            completion(nil, NetworkError.error(999, "Error constructing the PostsRequest"))
            return nil
        }

        let requestId = performRequest(request: request, completion: completion)
        return requestId
    }

    @discardableResult
    func requestComments(postId: Int,
                         page: Int,
                         commentsPerPage: Int?,
                         orderBy: CommentsOrderBy?,
                         direction: SortDirection?,
                         completion: @escaping (Comments?, Error?) -> Void) -> TaskId? {
        
        guard let request = CommentsRequest(apiConfiguration: apiConfiguration,
                                            postId: postId,
                                            page: page,
                                            commentsPerPage: commentsPerPage,
                                            orderBy: orderBy,
                                            direction: direction) else {
            completion(nil, NetworkError.error(999, "Error constructing the CommentsRequest"))
            return nil
        }
        
        let requestId = performRequest(request: request, completion: completion)
        return requestId
    }

    private func performRequest<T: NetworkRequest>(request: T,
                                                   completion: @escaping (T.ModelType?, Error?) -> Void) -> TaskId? {
        
        let id = service.request(request) { result in
            switch result {
            case .success(let response):
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        return id
    }

    private func performRequest(with url: URL,
                                completion: @escaping (Data?, Error?) -> Void) -> TaskId? {
        
        let requestId = service.request(with: url) { result in
            switch result {
            case .success(let response):
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        return requestId
    }
}

