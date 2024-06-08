//
//  Llog.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation

func log(_ text: String) {
    let thread = Thread.isMainThread ? "main thread" : "other thread"
    print("[\(thread)] \(text)")
}
