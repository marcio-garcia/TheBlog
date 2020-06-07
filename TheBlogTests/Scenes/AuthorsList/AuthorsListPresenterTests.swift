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

class AuthorsListPresenterTests: XCTestCase{
    // MARK: Subject under test
    var sut: AuthorsListPresenter!
  
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupAuthorsListPresenter()
    }
  
    override func tearDown(){
        super.tearDown()
    }
  
  // MARK: Test setup
    
    func setupAuthorsListPresenter(){
        sut = AuthorsListPresenter()
    }
  
  // MARK: Test doubles
  
    class AuthorsListDisplayLogicSpy: AuthorsListDisplayLogic {
        var displaySomethingCalled = false
    
        func displayAuthors(viewModel: AuthorsList.FetchAuthors.ViewModel) {
            displaySomethingCalled = true
        }
    }
  
  // MARK: Tests
    
    func testPresentSomething(){
        // Given
        let spy = AuthorsListDisplayLogicSpy()
        sut.viewController = spy
        let response = AuthorsList.FetchAuthors.Response()
    
        // When
        sut.presentAuthors(response: response)
    
        // Then
        XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}
