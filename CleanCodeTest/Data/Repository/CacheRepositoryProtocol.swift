//
//  CacheRepositoryProtocol.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation
import CoreData
import Combine

protocol CacheRepositoryProtocol {
    func save(_ data: Book) throws
    func fetch() -> [BookEntity]?
    func fetchItem(_ bookID: Int) -> BookEntity?
    func findByID(_ bookID: Int) -> BookEntity?
    func deleteByID(_ bookID: Int) throws
}

final class BookCacheRepository: CacheRepositoryProtocol {

    let coreDataManager: CoreDataManagerProtocol
    let subscriber = Cancelable()

    init(coreDataManager: CoreDataManagerProtocol = DIContainer.shared.inject(type: CoreDataManagerProtocol.self)!) {
        self.coreDataManager = coreDataManager
    }

    func save(_ item: Book) {
        let action: Action = {
            if let matchData = self.findByID(item.id) {
                matchData.bookID = Int64(item.id)
                matchData.image = item.formats.imageJPEG
                matchData.title = item.title
            } else {
                let book = NSEntityDescription.insertNewObject(forEntityName: Constants.DBName.bookEntity,
                                                               into: self.coreDataManager.viewContext)
                book.setValue(item.id, forKey: "bookID")
                book.setValue(item.formats.imageJPEG, forKey: "image")
                book.setValue(item.title, forKey: "title")
                
            }
        }
        self.coreDataManager
            .publisher(save: action)
            .sinkOnMain { completion in
                switch completion {
                case .failure(let error):
                    log("Saving Failure: \(error)")
                case .finished:
                    log("Completion")
                }
            } receiveValue: { success in
                if success {
                    log("Saving Done)")
                }
            }.store(in: subscriber)
    }

    func fetch() -> [BookEntity]? {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        var output: [BookEntity] = []
        self.coreDataManager
            .publisher(fetch: request)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    log("FetchData Failure: \(error)")
                case .finished:
                    log("Completion")
                }
            } receiveValue: { value in
                output.append(contentsOf: value)
            }.store(in: subscriber)
        return output
    }

    func fetchItem(_ bookID: Int) -> BookEntity? {
        if let matchData = findByID(bookID) {
            return matchData
        }
        return nil
    }

    func findByID(_ bookID: Int) -> BookEntity? {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        let idPredicate = NSPredicate(format: "bookID == %i", bookID)
        request.predicate = idPredicate
        var output: BookEntity?
        self.coreDataManager
            .publisher(fetch: request)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    log("FetchData Failure: \(error)")
                case .finished:
                    log("Completion")
                }
            } receiveValue: { value in
                output = value.first
            }.store(in: subscriber)
        return output
    }

    func deleteByID(_ bookID: Int) throws {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: BookEntity.entityName)
        let idPredicate = NSPredicate(format: "bookID == %i", bookID)
        request.predicate = idPredicate
        self.coreDataManager
            .publisher(delete: request)
            .sinkOnMain { completion in
                switch completion {
                case .failure(let error):
                    log("Delete Failure: \(error)")
                case .finished:
                    log("Completion")
                }
            } receiveValue: { _ in }
            .store(in: subscriber)
    }
}

