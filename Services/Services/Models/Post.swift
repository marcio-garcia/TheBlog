//
//  Post.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

public typealias Posts = [Post]

public struct Post: Codable {
    public let id: Int
    public let date, title, body: String
    public let imageURL: String
    public let authorID: Int

    enum CodingKeys: String, CodingKey {
        case id, date, title, body
        case imageURL = "imageUrl"
        case authorID = "authorId"
    }

    public init(id: Int, date: String, title: String, body: String, imageURL: String, authorID: Int) {
        self.id = id
        self.date = date
        self.title = title
        self.body = body
        self.imageURL = imageURL
        self.authorID = authorID
    }
}
