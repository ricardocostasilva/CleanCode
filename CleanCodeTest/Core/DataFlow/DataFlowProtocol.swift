//
//  DataFlowProtocol.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation

protocol DataFlowProtocol {
    associatedtype InputType
    func apply(_ input: InputType)
}
