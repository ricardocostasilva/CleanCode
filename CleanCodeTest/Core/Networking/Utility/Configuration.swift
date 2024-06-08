//
//  Configuration.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation

enum BaseURLType {
    case baseApi

    var desc: URL {
        switch self {
        case .baseApi:
            return URL("https://gutendex.com/")
        }
    }
}

enum VersionType {
    case none
    case v1, v2, v3
    var desc: String {
        switch self {
        case .none:
            return .empty
        case .v1:
            return "/v1"
        case .v2:
            return "/v2"
        case .v3:
            return "/v3"
        }
    }
}
