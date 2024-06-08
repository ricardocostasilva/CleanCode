//
//  MainCoordinator.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import SwiftUI
import Combine

struct MainCoordinator: CoordinatorProtocol {

    @StateObject var viewModel: MainViewModel

    @State var activeRoute: Destination? = Destination(route: .first(item: Book()))
    @State var transition: Transition?

    @State private var isLoaded: Bool = Bool()

    let subscriber = Cancelable()

    var body: some View {
        mainView
            .route(to: $activeRoute)
            .navigation()
            .onAppear {
                self.mainView.viewModel.navigateSubject
                    .sink { route in
                        activeRoute = Destination(route: route)
                    }.store(in: subscriber)
            }
    }

    var mainView: MainView {
        MainView(viewModel: viewModel)
    }
}

extension MainCoordinator {
    struct Destination: DestinationProtocol {

        var route: MainView.Routes

        @ViewBuilder
        var content: some View {
            switch route {
            case .first(let item):
                let viewModel: BookDetailViewModel = BookDetailViewModel(book: item)
                BookDetailView(viewModel: viewModel)
            }
        }
    
        var transition: Transition {
            switch route {
            case .first: return .push
            }
        }
    }
}


