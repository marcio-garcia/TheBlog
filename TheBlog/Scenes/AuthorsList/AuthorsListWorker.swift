//
//  AuthorsListWorker.swift
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

protocol AuthorsListWorkLogic {
    func requestAuthors(page: Int, authorsPerPage: Int?, completion: @escaping (Authors?, Error?) -> Void)
}

class AuthorsListWorker: AuthorsListWorkLogic {
    
    var service: BlogApi
    
    // MARK: Object Lifecycle
    
    init(service: BlogApi) {
        self.service = service
    }
    
    // MARK: AuthorsListWorkLogic
    
    func requestAuthors(page: Int, authorsPerPage: Int?, completion: @escaping (Authors?, Error?) -> Void) {
        service.requestAuthors(page: page, authorsPerPage: authorsPerPage) { authors, error in
            if let _error = error {
                completion(authors, _error)
            } else {
                completion(authors, error)
            }
        }
    }
}
