//
//  NetworkConfiguration.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Services

class NetworkConfiguration: ApiConfiguration {
    var environment: ApiEnvironment = .production
    var baseUrl: String = ""
    var apiToken: String = ""
    var debugMode = false

    init(baseUrl: String, apiToken: String) {
        self.baseUrl = baseUrl
        self.apiToken = apiToken
    }

    func setEnvironment(from environment: EnvironmentType) {
        switch environment {
        case .development:
            self.environment = .development
        case .staging:
            self.environment = .staging
        case .production:
            self.environment = .production
        }
    }
}

