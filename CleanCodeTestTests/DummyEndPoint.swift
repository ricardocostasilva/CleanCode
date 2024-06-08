//
//  DummyEndPoint.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import Foundation
@testable import CleanCodeTest

final class DummyTarget: NetworkTarget {
    var baseURL: BaseURLType = .baseApi
    
    var version: VersionType = .none
    
    var path: String? = "test/test"
    
    var methodType: HTTPMethod = .get
    
    var queryParams: [String : String]? = ["item": "item"]
    
    var queryParamsEncoding: URLEncoding? = .default
}
