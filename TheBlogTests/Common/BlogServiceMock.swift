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

    let addressMock = Address(latitude: "0", longitude: "0")
    lazy var authorsMock = [
        Author(id: 1, name: "Test", userName: "Test", email: "Test", avatarURL: "Test", address: addressMock),
        Author(id: 2, name: "Test", userName: "Test", email: "Test", avatarURL: "Test", address: addressMock),
        Author(id: 3, name: "Test", userName: "Test", email: "Test", avatarURL: "Test", address: addressMock),
        Author(id: 4, name: "Test", userName: "Test", email: "Test", avatarURL: "Test", address: addressMock)
    ]

    lazy var postsMock = [
        Post(id: 10, date: "2020-06-12T16:50:20.000Z", title: "Test", body: "Test", imageURL: "Test", authorID: 1),
        Post(id: 20, date: "2020-06-12T16:50:20.000Z", title: "Test", body: "Test", imageURL: "Test", authorID: 1),
        Post(id: 30, date: "2020-06-12T16:50:20.000Z", title: "Test", body: "Test", imageURL: "Test", authorID: 1),
        Post(id: 40, date: "2020-06-12T16:50:20.000Z", title: "Test", body: "Test", imageURL: "Test", authorID: 1)
    ]

    lazy var commentsMock = [
        Comment(id: 100, date: "Test", body: "Test", userName: "Test", email: "Test", avatarURL: "Test", postID: 10),
        Comment(id: 200, date: "Test", body: "Test", userName: "Test", email: "Test", avatarURL: "Test", postID: 10),
        Comment(id: 300, date: "Test", body: "Test", userName: "Test", email: "Test", avatarURL: "Test", postID: 10),
        Comment(id: 400, date: "Test", body: "Test", userName: "Test", email: "Test", avatarURL: "Test", postID: 10)
    ]

    func requestAuthors(page: Int, authorsPerPage: Int?, completion: @escaping (Authors?, Error?) -> Void) -> TaskId? {
        requestAuthorsCalled = true
        let startIndex = (page - 1) * authorsPerPage!
        let endIndex = startIndex + authorsPerPage!
        let authors = Array(authorsMock[startIndex ..< endIndex])
        completion(authors, nil)
        return TaskId()
    }

    func requestPosts(authorId: Int,
                      page: Int,
                      postsPerPage: Int?,
                      orderBy: PostsOrderBy?,
                      direction: SortDirection?, completion: @escaping (Posts?, Error?) -> Void) -> TaskId? {
        requestPostsCalled = true
        let startIndex = (page - 1) * postsPerPage!
        let endIndex = startIndex + postsPerPage!
        let posts = Array(postsMock[startIndex ..< endIndex])
        completion(posts, nil)
        return TaskId()
    }

    func requestComments(postId: Int,
                         page: Int,
                         commentsPerPage: Int?,
                         orderBy: CommentsOrderBy?,
                         direction: SortDirection?,
                         completion: @escaping (Comments?, Error?) -> Void) -> TaskId? {
        requestCommentsCalled = true
        let startIndex = (page - 1) * commentsPerPage!
        let endIndex = startIndex + commentsPerPage!
        let posts = Array(commentsMock[startIndex ..< endIndex])
        completion(posts, nil)
        return TaskId()
    }
    
    func cancel(taskId: TaskId) {
        requestCancelCalled = true
    }
}

