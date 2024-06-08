//
//  CoreDataTest.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import XCTest
import CoreData
import Combine
@testable import CleanCodeTest

final class CoreDataTest: CacheStack {
    
    var sut: CoreDataManagerProtocol!
    private var subscriber : Set<AnyCancellable> = []

    override func setUp() {
        sut = CoreDataManager(container: mockPersistentContainer)
    }

    override func tearDown() {
        subscriber.forEach { $0.cancel() }
        subscriber.removeAll()
        sut = nil
        clearMockData()
        super.tearDown()
    }
}

extension CoreDataTest {
    func testCoreDataSave_WhenSaveData_ShouldSaveMockData() {
        let  data = Book.mock
        
        let mockAction: Action = {
            let book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity",
                                                           into: self.mockPersistentContainer.viewContext)
            book.setValue(data.id, forKey: "bookID")
            book.setValue(data.formats.imageJPEG, forKey: "image")
            book.setValue(data.title, forKey: "title")

        }
        
        sut.publisher(save: mockAction)
            .sink { completion in
                
            } receiveValue: { state in
                XCTAssertEqual(state, true)
            }.store(in: &subscriber)
    }
    
    func testCoreDataFetch_WhenFetchData_ShouldSaveMockData() {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        sut.publisher(fetch: request)
            .sinkOnMain { _ in
            } receiveValue: { data in
                XCTAssertEqual(data.count, 1)
            }.store(in: &subscriber)
    }
}

