//
//  Post.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

typealias Posts = [Post]

struct Post: Codable {
    let id: Int
    let date, title, body: String
    let imageURL: String
    let authorID: Int

    enum CodingKeys: String, CodingKey {
        case id, date, title, body
        case imageURL = "imageUrl"
        case authorID = "authorId"
    }
}
