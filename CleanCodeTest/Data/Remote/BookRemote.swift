//
//  BookRemote.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation
import Combine

protocol BookRemoteProtocol: AnyObject {
     func fetch(page: Int) -> AnyPublisher<Books?, APIError>
}

final class BookRemote: NetworkClientManager<HttpRequest>, BookRemoteProtocol {
    func fetch(page: Int) -> AnyPublisher<Books?, APIError> {
        self.request(request: HttpRequest(request: BookRequest(page: page)),
                     scheduler: WorkScheduler.mainScheduler,
                     responseObject: Books?.self)
    }
}

struct BookRequest: NetworkTarget {

    let page: Int

    init(page: Int = 1) {
        self.page = page
    }

    var baseURL: BaseURLType {
        return .baseApi
    }

    var version: VersionType {
        return .none
    }

    var path: String? {
        return "/books/"
    }

    var methodType: HTTPMethod {
        .get
    }

    var queryParams: [String: String]? {
        return ["page": String(page)]
    }

    var queryParamsEncoding: URLEncoding? {
        return .default
    }
}

