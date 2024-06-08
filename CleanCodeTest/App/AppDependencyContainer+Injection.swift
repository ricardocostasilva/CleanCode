//
//  AppDependencyContainer+Injection.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation

extension DIContainer {
    func registration() {
        
        register(type: BookRemoteProtocol.self, component: BookRemote())
        register(type: BookRepositoryProtocol.self, component: BookRepository())
        register(type: CoreDataManagerProtocol.self, component: CoreDataManager())
        register(type: CacheRepositoryProtocol.self, component: BookCacheRepository())
        register(type: BookUseCaseProtocol.self, component: BookUsecase())
        
    }
}
