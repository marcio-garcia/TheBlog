//
//  PostsRequest.swift
//  Services
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Ivorywhite

public enum PostsOrderBy: String {
    case id
    case date
    case authorId
}

class PostsRequest: Request, NetworkRequest {
    typealias ModelType = Posts
    
    init?(apiConfiguration: ApiConfiguration,
          authorId: Int,
          page: Int,
          postsPerPage: Int?,
          orderBy: PostsOrderBy?,
          direction: SortDirection?) {

        super.init()
        
        guard let apiBaseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }
        
        baseURL = apiBaseURL
        path = "/posts"
        httpMethod = .get
        encoding = .urlEnconding
        parameters = [
            "authorId": authorId,
            "_page": page
        ]

        if let limit = postsPerPage {
            parameters?["_limit"] = limit
        }

        if let order = orderBy {
            parameters?["_sort"] = order.rawValue
            if let dir = direction {
                parameters?["_order"] = dir.rawValue
            }
        }
    }
    
    func parse(data: Data) throws -> ModelType? {
        let authors = try? JSONDecoder().decode(ModelType.self, from: data)
        return authors
    }
}
