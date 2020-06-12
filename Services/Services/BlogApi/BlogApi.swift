//
//  BlogApi.swift
//  Services
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Ivorywhite

public protocol BlogApi {
    @discardableResult
    func requestAuthors(page: Int, authorsPerPage: Int?, completion: @escaping (Authors?, Error?) -> Void) -> TaskId?
    @discardableResult
    func requestPosts(authorId: Int,
                      page: Int,
                      postsPerPage: Int?,
                      orderBy: PostsOrderBy?,
                      direction: SortDirection?,
                      completion: @escaping (Posts?, Error?) -> Void) -> TaskId?
    @discardableResult
    func requestComments(page: Int, commentsPerPage: Int?, completion: @escaping (Comments?, Error?) -> Void) -> TaskId?
    func cancel(taskId: TaskId)
}
