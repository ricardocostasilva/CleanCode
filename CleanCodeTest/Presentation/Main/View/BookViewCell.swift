//
//  BookViewCell.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import SwiftUI

struct BookCellView: View {

    var item: Book
    
    @ObservedObject var viewModel: MainViewModel
    
    @State var isPersist: Bool = false

    var body: some View {
 
            HStack {
                ImageView(withURL: item.formats.safeImageURL())
                    .frame(width: 50.0, height: 70.0)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.title)
                        .foregroundColor(Color.black)
                    Text("\(viewModel.getAuthorsIfExist(authors: item.authors))")
                        .foregroundColor(Color.gray)
                }
                Spacer()
                
                ZStack {
                    Button(action: { }, label: {
                        Image(systemName: isPersist ? "bookmark.fill" : "bookmark")
                            .font(.system(size: 30))
                            .foregroundColor(.yellow)
                            .offset(x: 10, y: -55)
                    })
                    .onTapGesture {
                        self.handleDataPersistance(item: item)
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .onAppear{
                self.isPersist = self.viewModel.checkIfItemExist(item)
            }                   
            .onTapGesture {
                self.viewModel.didTapFirst(item: item)
            }
            
    }
    
    func handleDataPersistance(item: Book) {
        if isPersist {
            self.isPersist = false
            self.viewModel.deleteFromFavorites(item)
        } else {
            self.isPersist = true
            self.viewModel.addToFavorites(item)
        }
    }
}
