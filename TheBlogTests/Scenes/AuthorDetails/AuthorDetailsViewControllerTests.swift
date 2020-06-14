//
//  AuthorDetailsViewControllerTests.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright (c) 2020 Oxl Tech. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import TheBlog
import XCTest
import Services

class AuthorDetailsViewControllerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: AuthorDetailsViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        window = UIWindow()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
  
  // MARK: Tests
    
    func testShouldFetchAuthorsWhenViewIsLoaded() {
        // Given
        let spy = AuthorDetailsBusinessLogicSpy()
        sut = AuthorDetailsViewController()
        sut.interactor = spy
    
        // When
        loadView()
    
        // Then
        XCTAssertTrue(spy.fetchFirstPostsCalled,
                      "viewDidLoad() should ask the interactor to fetch the first page of posts")
    }
  
    func testDisplayPosts() {
        // Given
        let contentView = AuthorDetailsContentViewSpy()
        sut = AuthorDetailsViewController()
        sut.contentView = contentView

        // When
        loadView()
        sut.displayPosts([])
    
        // Then
        XCTAssertTrue(contentView.updatePostsCalled, "displayPosts() should update the contentView")
    }

    func testDisplayAuthor(_ author: Author?) {
        // Given
        let contentView = AuthorDetailsContentViewSpy()
        sut = AuthorDetailsViewController()
        sut.contentView = contentView

        // When
        loadView()
        sut.displayAuthor(nil)

        // Then
        XCTAssertTrue(contentView.updateAuthorCalled, "displayAuthor() should update the contentView")
    }
}

// MARK: Test doubles

class AuthorDetailsBusinessLogicSpy: AuthorDetailsBusinessLogic {
    var fetchAuthorCalled = false
    var fetchFirstPostsCalled = false
    var fetchNextPostsCalled = false
    var selectPostCalled = false

    func fetchAuthor() {
        fetchAuthorCalled = true
    }

    func fetchFirstPosts() {
        fetchFirstPostsCalled = true
    }

    func fetchNextPosts() {
        fetchNextPostsCalled = true
    }

    func selectPost(_ post: Post?) {
        selectPostCalled = true
    }
}

class AuthorDetailsContentViewSpy: UIView, AuthorDetailsContentViewProtocol {
    var updateAuthorCalled = false
    var updatePostsCalled = false

    func updateAuthor(author: Author?) {
        updateAuthorCalled = true
    }

    func updatePosts(posts: Posts) {
        updatePostsCalled = true
    }
}
