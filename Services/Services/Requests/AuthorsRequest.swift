//
//  AuthorsRequest.swift
//  Services
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Ivorywhite

class AuthorsRequest: Request, NetworkRequest {
    
    typealias ModelType = Authors
    typealias ErrorModelType = BlogError
    
    init?(apiConfiguration: ApiConfiguration, page: Int, authorsPerPage: Int?) {
        super.init()
        
        guard let _baseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }
        
        baseURL = _baseURL
        path = "/authors"
        httpMethod = .get
        encoding = .urlEnconding
        parameters = [
            "_page": page
        ]
        if let limit = authorsPerPage {
            parameters?["_limit"] = limit
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
