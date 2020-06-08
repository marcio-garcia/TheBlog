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
            completion(nil, NetworkError.badRequest)
            return nil
        }
        
        let requestId = performRequest(request: request, completion: completion)
        return requestId
    }

    @discardableResult
    func requestPosts(page: Int, postsPerPage: Int?, completion: @escaping (Posts?, Error?) -> Void) -> TaskId? {
        
        guard let request = PostsRequest(apiConfiguration: apiConfiguration,
                                         page: page,
                                         postsPerPage: postsPerPage) else {
            completion(nil, NetworkError.badRequest)
            return nil
        }
        
        let requestId = performRequest(request: request, completion: completion)
        return requestId
    }

    @discardableResult
    func requestComments(page: Int, commentsPerPage: Int?, completion: @escaping (Comments?, Error?) -> Void) -> TaskId? {
        
        guard let request = CommentsRequest(apiConfiguration: apiConfiguration,
                                            page: page,
                                            commentsPerPage: commentsPerPage) else {
            completion(nil, NetworkError.badRequest)
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

