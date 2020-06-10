//
//  AuthorsListPresenterTests.swift
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

class AuthorsListPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: AuthorsListPresenter!
  
  // MARK: Tests
    
    func testPresentAuthors() {
        // Given
        sut = AuthorsListPresenter()
        let spy = AuthorsListDisplayLogicSpy()
        sut.viewController = spy
        let response = AuthorsList.FetchAuthors.Response(authors: [])
    
        // When
        sut.presentAuthors(response: response)
    
        // Then
        XCTAssertTrue(spy.displayAuthorsCalled, "presentAuthors() should ask the view controller to display the result")
    }

    func testPresentError() {
        // Given
        sut = AuthorsListPresenter()
        let spy = AuthorsListDisplayLogicSpy()
        sut.viewController = spy
        let response = AuthorsList.Error.Response(message: "Error")

        // When
        sut.presentError(response: response)

        // Then
        XCTAssertTrue(spy.displayErrorCalled, "presentError() should ask the view controller to display the error")
    }
}

// MARK: Test doubles

class AuthorsListDisplayLogicSpy: AuthorsListDisplayLogic {
    var displayAuthorsCalled = false
    var displayErrorCalled = false

    func displayAuthors(viewModel: AuthorsList.FetchAuthors.ViewModel) {
        displayAuthorsCalled = true
    }

    func displayError(viewModel: AuthorsList.Error.ViewModel) {
        displayErrorCalled = true
    }
}
