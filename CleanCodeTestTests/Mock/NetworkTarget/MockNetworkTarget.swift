//
//  MockNetworkTarget.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import Foundation
@testable import CleanCodeTest

class MockNetworkTarget: NetworkTarget {
    var baseURL: BaseURLType = .baseApi
    
    var version: VersionType = .none
    
    var path: String? = "book"
    
    var methodType: HTTPMethod = .get
    
    var queryParams: [String : String]? = ["test": "test"]
    
    var queryParamsEncoding: URLEncoding? = .default
}
