//
//  BookUseCaseMock.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import Foundation
import Combine
@testable import CleanCodeTest

final class BookUseCaseMock: BookUseCaseProtocol {
    let mockBookRepisitory = BookRepositoryMock()
    func execute(page: Int) -> AnyPublisher<Books?, APIError> {
        return mockBookRepisitory.data(page: page)
    }
}
