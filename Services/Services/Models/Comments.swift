//
//  Comments.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

public typealias Comments = [Comment]

public struct Comment: Codable {
    public let id: Int
    public let date, body, userName, email: String
    public let avatarURL: String
    public let postID: Int

    enum CodingKeys: String, CodingKey {
        case id, date, body, userName, email
        case avatarURL = "avatarUrl"
        case postID = "postId"
    }

    public init(id: Int, date: String, body: String, userName: String, email: String, avatarURL: String, postID: Int) {
        self.id = id
        self.date = date
        self.body = body
        self.userName = userName
        self.email = email
        self.avatarURL = avatarURL
        self.postID = postID
    }
}
