//
//  BookDetailViewModel.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation

final class BookDetailViewModel: ObservableObject {

    let title: String = Constants.Title.mainTitle
    @Published var book: Book

    private let repository: CacheRepositoryProtocol

    init(repository: CacheRepositoryProtocol = DIContainer.shared.inject(type: CacheRepositoryProtocol.self)!, book: Book) {
        self.repository = repository
        self.book = book
    }

    func addToFavorites(_ data: Book) {
        _ = try? self.repository.save(data)
    }

    func deleteFromFavorites(_ data: Book) {
        _ = try? self.repository.deleteByID(data.id)
    }

    func checkIfItemExist(_ data: Book) -> Bool {
        if (repository.fetchItem(data.id)) != nil {
            return true
        }
        return false
    }
    
    func getAuthorsIfExist() -> String? {
        if book.authors.isEmpty {
            return ""
        }
        
        return book.authors[0].name
    }
    
    func getSubjectsIfExist() -> String {
        if book.subjects.isEmpty {
            return ""
        }
        
        return book.subjects[0]
    }
    
    func getAuthorBirthDeathDate() -> String {
        guard !book.authors.isEmpty else {
            return ""
        }
        
        if let birthYear = book.authors[0].birthYear, let deathYear = book.authors[0].deathYear {
            return "\(birthYear) - \(deathYear)"
        } else {
            return ""
        }
    }
}

