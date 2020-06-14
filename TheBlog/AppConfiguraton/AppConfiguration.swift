//
//  AppConfiguration.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Foundation

public enum PlistKey: String {
    case environment    = "ENVIRONMENT"
    case bundleId       = "CFBundleIdentifier"
    case appVersion     = "CFBundleShortVersionString"
    case baseUrl        = "API_BASE_URL"
}

public enum EnvironmentType: String {
    case development    =  "development"
    case staging        =  "staging"
    case production     =  "production"
}

public struct AppConfiguration {

    private var infoDictionary: [String: Any] {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }
            else {
                fatalError("plist file not found")
            }
        }
    }

    public var environment: EnvironmentType {
        let envString = self.value(for: .environment)
        if let envType = EnvironmentType(rawValue: envString) {
            return envType
        }
        return EnvironmentType.production
    }

    public func value(for key: PlistKey) -> String {
        guard let val = self.infoDictionary[key.rawValue] as? String else { return "" }
        let finalValue = val.replacingOccurrences(of: "\\", with: "")
        return finalValue
    }
}
