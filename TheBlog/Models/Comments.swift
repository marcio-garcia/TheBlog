//
//  Comments.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

typealias Comments = [Comment]

struct Comment: Codable {
    let id: Int
    let date, body, userName, email: String
    let avatarURL: String
    let postID: Int

    enum CodingKeys: String, CodingKey {
        case id, date, body, userName, email
        case avatarURL = "avatarUrl"
        case postID = "postId"
    }
}
