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
    
    init?(apiConfiguration: ApiConfiguration) {
        super.init()
        
        guard let baseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }
        
        self.baseURL = baseURL
        self.path = "/authors"
        self.httpMethod = .get
        self.httpHeaders = [
            "Content-Type": "application/json;charset=utf-8"
        ]
    }
    
    func parse(data: Data) throws -> ModelType? {
        let authors = try? JSONDecoder().decode(ModelType.self, from: data)
        return authors
    }
}
