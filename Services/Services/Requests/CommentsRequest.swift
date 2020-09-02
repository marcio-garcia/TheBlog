//
//  CommentsRequest.swift
//  Services
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Ivorywhite

public enum CommentsOrderBy: String {
    case id
    case date
    case userName
    case postId
}

class CommentsRequest: Request, NetworkRequest {

    typealias ModelType = Comments
    typealias ErrorModelType = BlogError
    
    init?(apiConfiguration: ApiConfiguration,
          postId: Int,
          page: Int,
          commentsPerPage: Int?,
          orderBy: CommentsOrderBy?,
          direction: SortDirection?) {
        
        super.init()
        
        guard let apiBaseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }
        
        baseURL = apiBaseURL
        path = "/comments"
        httpMethod = .get
        encoding = .urlEnconding
        parameters = [
            "_page": page
        ]
        if let limit = commentsPerPage {
            parameters?["_limit"] = limit
        }

        parameters = [
            "postId": postId,
            "_page": page
        ]

        if let limit = commentsPerPage {
            parameters?["_limit"] = limit
        }

        if let order = orderBy {
            parameters?["_sort"] = order.rawValue
            if let dir = direction {
                parameters?["_order"] = dir.rawValue
            }
        }
    }
    
    func parse(data: Data) -> ModelType? {
        let authors = try? JSONDecoder().decode(ModelType.self, from: data)
        return authors
    }

    func parseError(data: Data) -> ErrorModelType? {
        let error = try? JSONDecoder().decode(ErrorModelType.self, from: data)
        return error
    }
}
