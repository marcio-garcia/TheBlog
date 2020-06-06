//
//  Request.swift
//  Services
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Ivorywhite

class Request {
    var baseURL: URL = URL(string: "https://empty.com")!
    var path: String = ""
    var httpMethod: HTTPMethod = .get
    var httpHeaders: HTTPHeader?
    var parameters: Parameters?
    var encoding: ParameterEncoding?
}
