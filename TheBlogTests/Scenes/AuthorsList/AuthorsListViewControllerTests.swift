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

class AuthorsListViewControllerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: AuthorsListViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupAuthorsListViewController()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupAuthorsListViewController() {
        sut = AuthorsListViewController()
    }
  
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
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
    }
  
  // MARK: Tests
    
    func testShouldDoSomethingWhenViewIsLoaded() {
        // Given
        let spy = AuthorsListBusinessLogicSpy()
        sut.interactor = spy
    
        // When
        loadView()
    
        // Then
        XCTAssertTrue(spy.fetchFirstAuthorsCalled, "viewDidLoad() should ask the interactor to do something")
    }
  
    func testDisplaySomething() {
        // Given
        let viewModel = AuthorsList.FetchAuthors.ViewModel(displayedAuthors: [])
    
        // When
        loadView()
        sut.displayAuthors(viewModel: viewModel)
    
        // Then
        //XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update the name text field")
    }
}
