//
//  BlogServiceMock.swift
//  TheBlogTests
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Services
import Ivorywhite

class BlogServiceMock: BlogApi {
    var requestAuthorsCalled = false
    var requestPostsCalled = false
    var requestCommentsCalled = false
    var requestCancelCalled = false
    
    func requestAuthors(page: Int, authorsPerPage: Int?, completion: @escaping (Authors?, Error?) -> Void) -> TaskId? {
        requestAuthorsCalled = true
        let addressMock = Address(latitude: "0", longitude: "0")
        let authorMock = Author(id: 0, name: "Test", userName: "Test", email: "Test", avatarURL: "Test", address: addressMock)
        completion([authorMock], nil)
        return TaskId()
    }
    
    func requestPosts(page: Int, postsPerPage: Int?, completion: @escaping (Posts?, Error?) -> Void) -> TaskId? {
        requestPostsCalled = true
        return TaskId()
    }
    
    func requestComments(page: Int, commentsPerPage: Int?, completion: @escaping (Comments?, Error?) -> Void) -> TaskId? {
        requestCommentsCalled = true
        return TaskId()
    }
    
    func cancel(taskId: TaskId) {
        requestCancelCalled = true
    }
}

