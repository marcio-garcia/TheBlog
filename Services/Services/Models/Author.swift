//
//  Author.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

public typealias Authors = [Author]

public struct Author: Codable {
    public let id: Int
    public let name, userName, email: String
    public let avatarURL: String
    public let address: Address

    enum CodingKeys: String, CodingKey {
        case id, name, userName, email
        case avatarURL = "avatarUrl"
        case address
    }
    
    public init(id: Int, name: String, userName: String, email: String, avatarURL: String, address: Address) {
        self.id = id
        self.name = name
        self.userName = userName
        self.email = email
        self.avatarURL = avatarURL
        self.address = address
    }
}

public struct Address: Codable {
    public let latitude, longitude: String
    
    public init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
