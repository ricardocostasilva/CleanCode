//
//  MainViewModelTest.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//


import XCTest
import Combine
@testable import CleanCodeTest

final class MainViewModelTest: XCTestCase {

    private var viewModelToTest: MainViewModel!
    private var book: BookRemoteMock!
    private var subscriber : Set<AnyCancellable> = []
    
    private var input: MainViewModel.InputType!
    
    override func setUp()  {
        viewModelToTest = MainViewModel()
        book = BookRemoteMock()
        input = MainViewModel.InputType.onAppear
    }
    
    override func tearDown() {
        subscriber.forEach { $0.cancel() }
        subscriber.removeAll()
        viewModelToTest = nil
        book = nil
        input = nil
        super.tearDown()
    }
    
    func testMainViewModel_WhenBookServiceCalled_ShouldReturnResponse() {
        //Arrange
        let data = Book.mockArray

        let expectation = XCTestExpectation(description: "State")
        // Act
        viewModelToTest.loadingState.dropFirst().sink { event in
            XCTAssertEqual(event, .loadStart)
              expectation.fulfill()
        }.store(in: &subscriber)
        // Assert
        book.fetchedResult = Result.success(data).publisher.eraseToAnyPublisher()
        viewModelToTest.getBooksData()

        wait(for: [expectation], timeout: 1)
    }
    
    func testMainViewModel_WhenBookServiceCalled_ShouldReturnNil() {
        //Arrange
        let data = Books(count: 100, next: "", previous: "", results: [])

        let expectation = XCTestExpectation(description: "State")
        // Act
        viewModelToTest.loadingState.dropFirst().sink { event in
            XCTAssertEqual(event, .loadStart)
              expectation.fulfill()
        }.store(in: &subscriber)
        // Assert
        book.fetchedResult = Result.success(data).publisher.eraseToAnyPublisher()
        viewModelToTest.getBooksData()

        wait(for: [expectation], timeout: 1)
    }

}
