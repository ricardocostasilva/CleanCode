//
//  CacheStack.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import XCTest
import CoreData
import Combine
@testable import CleanCodeTest

class CacheStack: XCTestCase {

    lazy var mockPersistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "BooksDB")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { (description, error) in
            precondition(description.type == NSInMemoryStoreType)
            
            if let error = error {
                fatalError("Unable to create in memory persistent store")
            }
        }
        return persistentContainer
    }()

    func clearMockData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "BookEntity")
        let objects = try! mockPersistentContainer.viewContext.fetch(fetchRequest)
        
        objects.forEach { object in
            guard let object = object as? NSManagedObject else {
                return
            }
            mockPersistentContainer.viewContext.delete(object)
        }
        
        try? mockPersistentContainer.viewContext.save()
    }
}

