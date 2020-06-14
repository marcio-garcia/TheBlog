//
//  ServicesTests.swift
//  ServicesTests
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import XCTest
import Ivorywhite
@testable import Services

class ServicesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBlogServiceRequestAuthors() throws {
        let service = NetworkServiceSpy()
        let sut = BlogService(apiConfiguration: ApiConfigurationMock(), service: service)
        sut.requestAuthors { (authors, error) in
            XCTAssertTrue(service.resquestWithRequestObjectCalled)
        }
    }
    
    func testBlogServiceRequestPosts() throws {
        let service = NetworkServiceSpy()
        let sut = BlogService(apiConfiguration: ApiConfigurationMock(), service: service)
        sut.requestPosts { (posts, error) in
            XCTAssertTrue(service.resquestWithRequestObjectCalled)
        }
    }
    
    func testBlogServiceRequestComments() throws {
        let service = NetworkServiceSpy()
        let sut = BlogService(apiConfiguration: ApiConfigurationMock(), service: service)
        sut.requestComments { (comments, error) in
            XCTAssertTrue(service.resquestWithRequestObjectCalled)
        }
    }
    
    func testBlogServiceCancel() throws {
        let service = NetworkServiceSpy()
        let sut = BlogService(apiConfiguration: ApiConfigurationMock(), service: service)
        sut.cancel(taskId: TaskId.init())
        XCTAssertTrue(service.resquestCancelCalled)
    }
}

class ApiConfigurationMock: ApiConfiguration {
    var environment: ApiEnvironment = .development
    var baseUrl: String = "https://empty.com"
    var apiToken: String = ""
    var debugMode: Bool = false
}

class NetworkServiceSpy: NetworkService {
    var resquestWithRequestObjectCalled = false
    var resquestWithUrlCalled = false
    var resquestCancelCalled = false
    
    func request<T>(_ networkRequest: T, completion: @escaping (Result<Response<T.ModelType>, Error>) -> Void) -> TaskId where T : NetworkRequest {
        self.resquestWithRequestObjectCalled = true
        return UUID.init()
    }
    
    func request(with url: URL, completion: @escaping (Result<Response<Data>, Error>) -> Void) -> TaskId {
        self.resquestWithUrlCalled = true
        return UUID.init()
    }
    
    func cancel(taskId: TaskId) {
        self.resquestCancelCalled = true
    }
}
