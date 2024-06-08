//
//  BookRepository.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation
import Combine

protocol BookRepositoryProtocol {
    func data(page: Int) -> AnyPublisher<Books?, APIError>
}

final class BookRepository {

    private let service: BookRemoteProtocol

    init(service: BookRemoteProtocol = DIContainer.shared.inject(type: BookRemoteProtocol.self)!) {
        self.service = service
    }
}

extension BookRepository: BookRepositoryProtocol {
    func data(page: Int) -> AnyPublisher<Books?, APIError> {
        return self.service.fetch(page: page)
    }
}

