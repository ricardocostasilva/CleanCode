//
//  BookRemoteMock.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import Foundation
import Combine
@testable import CleanCodeTest

final class BookRemoteMock: BookRemoteProtocol {
    var fetchedResult: AnyPublisher <Books?, APIError>!
    func fetch(page: Int) -> AnyPublisher<Books?, CleanCodeTest.APIError> {
        return fetchedResult
    }
}
