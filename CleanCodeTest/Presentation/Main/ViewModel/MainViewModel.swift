//
//  MainViewModel.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation
import Combine

protocol MainViewModelProtocol {
    func getBooksData()
}

protocol DefaultMainViewModel: MainViewModelProtocol { }

final class MainViewModel: DefaultViewModel, DefaultMainViewModel {
    
    let title: String = Constants.Title.mainTitle
    
    private let bookUseCase: BookUseCaseProtocol
    private let repository: CacheRepositoryProtocol
    
    var page: Int = 1
    
    @Published var bookData: [Book] = []
    
    var navigateSubject = PassthroughSubject<MainView.Routes, Never>()
    
    init(bookUseCase: BookUseCaseProtocol = DIContainer.shared.inject(type: BookUseCaseProtocol.self)!, repository: CacheRepositoryProtocol = DIContainer.shared.inject(type: CacheRepositoryProtocol.self)!) {
        self.bookUseCase = bookUseCase
        self.repository = repository
    }
    
}


extension MainViewModel: DataFlowProtocol {
    
    typealias InputType = Load
    
    enum Load {
        case onAppear
    }
    
    func apply(_ input: Load) {
        switch input {
        case .onAppear:
            self.callFirstTime()
        }
    }
    
    func callFirstTime() {
        guard self.bookData.isEmpty else { return }
        self.getBooksData()
    }
    
    func loadMore() {
        self.getBooksData()
    }
    
    func didTapFirst(item: Book) {
        self.navigateSubject.send(.first(item: item))
    }
    
    func getBooksData() {
        self.call(argument: self.bookUseCase.execute(page: self.page)) { [weak self] bookData in
            guard let bookData = bookData else { return }
            self?.bookData.append(contentsOf: bookData.results)
            self?.page += 1
        }
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
    
    func getAuthorsIfExist(authors: [Author]) -> String {
        if authors.isEmpty {
            return ""
        }
        
        return authors[0].name
    }
    
}
