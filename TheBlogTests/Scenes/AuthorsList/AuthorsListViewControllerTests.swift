//
//  AuthorsListViewControllerTests.swift
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

class AuthorsListViewControllerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: AuthorsListViewController!
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
        let spy = AuthorsListBusinessLogicSpy()
        sut = AuthorsListViewController()
        sut.interactor = spy
    
        // When
        loadView()
    
        // Then
        XCTAssertTrue(spy.fetchFirstAuthorsCalled, "viewDidLoad() should ask the interactor to fetch the first page of authors")
    }
  
    func testDisplayAuthors() {
        // Given
        let viewModel = AuthorsList.FetchAuthors.ViewModel(authors: [])
        let contentView = AuthorsListContentViewSpy()
        sut = AuthorsListViewController()
        sut.contentView = contentView

        // When
        loadView()
        sut.displayAuthors(viewModel: viewModel)
    
        // Then
        XCTAssertTrue(contentView.updateAuthorsCalled, "displayAuthors() should update the contentView")
    }
}

// MARK: Test doubles

class AuthorsListBusinessLogicSpy: AuthorsListBusinessLogic {
    var fetchFirstAuthorsCalled = false
    var fetchNextAuthorsCalled = false

    func fetchFirstAuthors() {
        fetchFirstAuthorsCalled = true
    }

    func fetchNextAuthors() {
        fetchNextAuthorsCalled = true
    }

    func selectAuthor(_ author: Author?) {
    }
}

class AuthorsListContentViewSpy: UIView, AuthorsListContentViewProtocol {
    var updateAuthorsCalled = false
    func updateAuthors(displayedAuthors: Authors) {
        updateAuthorsCalled = true
    }
}
