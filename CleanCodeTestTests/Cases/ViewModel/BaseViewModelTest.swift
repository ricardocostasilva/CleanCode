//
//  BaseViewModelTest.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import XCTest
import Combine
@testable import CleanCodeTest

final class BaseViewModelTest: XCTestCase {
    
    private var remote: BookRemoteMock!
    private var viewModelToTest: DefaultViewModel!
    private var subscriber : Set<AnyCancellable> = []

    override func setUp()  {
        remote = BookRemoteMock()
        viewModelToTest = DefaultViewModel()
    }
    
    override func tearDown() {
        subscriber.forEach { $0.cancel() }
        subscriber.removeAll()
        remote = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testBaseViewModel_WhenCallWithProgress_ShouldReturnValue() {
        //Arrange
        let data = Book.mockArray
        
        remote.fetchedResult = Result.success(data).publisher.eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "State is set to Token")
        let viewModel = self.viewModelToTest
        // Act
        viewModel?.loadingState.dropFirst().sink { event in
            expectation.fulfill()
            XCTAssertEqual(event, .loadStart)
        }.store(in: &subscriber)

        viewModel?.call(argument: self.remote.fetch(page: 1)) { data in
        // Assert
            expectation.fulfill()
            XCTAssertTrue(data?.results as Any is [Book])
            XCTAssertTrue(data as Any is Decodable)
        }
        
        viewModel?.loadingState.dropFirst().sink(receiveValue: { event in
            expectation.fulfill()
            XCTAssertEqual(event, .dismissAlert)
        }).store(in: &subscriber)

        wait(for: [expectation], timeout: 1)
    }
    
    func testBaseViewModel_WhenCallWithProgress_ShouldReturnNil() {
        //Arrange
        let data: Books = Books(count: 1, next: "", previous: "", results: [])
        
        remote.fetchedResult = Result.success(data).publisher.eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "State is set to Token")
        
        let viewModel = self.viewModelToTest
        // Act
        viewModel?.call(argument: self.remote.fetch(page: 1)) { data in
        // Assert
        expectation.fulfill()
            XCTAssertTrue(data?.results as Any is [Book])
        }

        wait(for: [expectation], timeout: 1)
    }
}

