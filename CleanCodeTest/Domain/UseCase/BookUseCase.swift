//
//  BookUseCase.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation
import Combine

protocol BookUseCaseProtocol: AnyObject {
    func execute(page: Int) -> AnyPublisher<Books?, APIError>
}

final class BookUsecase: BookUseCaseProtocol {

    private let bookRepository: BookRepositoryProtocol
    //private let persistance: CacheRepositoryProtocol
    var subscriber = Cancelable()

    init(bookRepository: BookRepositoryProtocol = DIContainer.shared.inject(type: BookRepositoryProtocol.self)!) {
        self.bookRepository = bookRepository
    }

    func execute(page: Int) -> AnyPublisher<Books?, APIError> {
            self.bookRepository.data(page: page)
    }
}
