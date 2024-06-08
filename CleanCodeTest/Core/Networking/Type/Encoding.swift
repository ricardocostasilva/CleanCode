//
//  Encoding.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation

public enum URLEncoding: String {
    // Generally for these methods - GET, HEAD, DELETE, CONNECT, OPTIONS
    case `default`
    case percentEncoded
}

public enum BodyEncoding: String {
    case JSON
}

