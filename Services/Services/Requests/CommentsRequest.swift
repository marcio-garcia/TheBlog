//
//  CommentsRequest.swift
//  Services
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Ivorywhite

class CommentsRequest: Request, NetworkRequest {
    typealias ModelType = Comments
    
    init?(apiConfiguration: ApiConfiguration, page: Int, commentsPerPage: Int?) {
        super.init()
        
        guard let apiBaseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }
        
        baseURL = apiBaseURL
        path = "/comments"
        httpMethod = .get
        parameters = [
            "_page": page
        ]
        if let limit = commentsPerPage {
            parameters?["_limit"] = limit
        }
    }
    
    func parse(data: Data) throws -> ModelType? {
        let authors = try? JSONDecoder().decode(ModelType.self, from: data)
        return authors
    }
}
