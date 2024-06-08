//
//  BookRepositoryMock.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import Foundation
import Combine
@testable import CleanCodeTest

final class BookRepositoryMock: BookRepositoryProtocol {
    let mockBookService = BookRemoteMock()
    func data(page: Int) -> AnyPublisher<Books?, APIError> {
         return mockBookService.fetchedResult
    }
}

