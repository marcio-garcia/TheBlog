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
    func requestAuthors(completion: @escaping (Authors?, Error?) -> Void) -> TaskId?
    @discardableResult
    func requestPosts(completion: @escaping (Posts?, Error?) -> Void) -> TaskId?
    @discardableResult
    func requestComments(completion: @escaping (Comments?, Error?) -> Void) -> TaskId?
    func cancel(taskId: TaskId)
}
