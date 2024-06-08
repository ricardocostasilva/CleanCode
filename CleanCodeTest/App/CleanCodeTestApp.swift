//
//  CleanCodeTestApp.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 26/04/2024.
//

import SwiftUI

@main
struct CleanCodeTestApp: App {
    
    @StateObject var viewModel: MainViewModel = MainViewModel()
    
    init() {
        DIContainer.shared.registration()
    }
    
    var body: some Scene {
        WindowGroup {
            MainCoordinator(viewModel: viewModel)
        }
    }
}
