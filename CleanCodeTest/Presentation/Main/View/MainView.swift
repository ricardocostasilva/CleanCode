//
//  MainView.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import SwiftUI
import Combine

struct MainView: Coordinatable {
    
    typealias Route = Routes
    
    @ObservedObject var viewModel: MainViewModel
    
    enum Constant {
        static let cornerRadius: CGFloat = 10
    }
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        List {
            ForEach(viewModel.bookData, id: \.id) { item  in
                BookCellView(item: item, viewModel: viewModel)
                    .frame(height: 100)
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 3) // Light shadow
            }
            
            if isLoading {
                ZStack {
                    RoundedRectangle(cornerRadius: Constant.cornerRadius)
                        .foregroundColor(Color.red.opacity(0.8))
                        .frame(width: 40.0, height: 40.0)
                    ActivityIndicator(style: .medium, animate: .constant(true))
                }
            } else {
                Color.white
                    .onAppear {
                        if !isLoading, !self.viewModel.bookData.isEmpty {
                            self.viewModel.loadMore()
                        }
                    }
            }
        }
        .navigationTitle("Books")
        .onViewDidLoad {
            self.viewModel.apply(.onAppear)
        }
    }
}

extension MainView {
    enum Routes: Routing {
        case first(item: Book)
    }
}
