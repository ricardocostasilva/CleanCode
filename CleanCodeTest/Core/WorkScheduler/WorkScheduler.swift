//
//  WorkScheduler.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation
import Combine

final class WorkScheduler {

    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    static let mainScheduler = RunLoop.main
    static let mainThread = DispatchQueue.main
}
