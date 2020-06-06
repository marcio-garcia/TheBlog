//
//  Author.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

typealias Authors = [Author]

struct Author: Codable {
    let id: Int
    let name, userName, email: String
    let avatarURL: String
    let address: Address

    enum CodingKeys: String, CodingKey {
        case id, name, userName, email
        case avatarURL = "avatarUrl"
        case address
    }
}

struct Address: Codable {
    let latitude, longitude: String
}
