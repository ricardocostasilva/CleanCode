//
//  DetailView.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import SwiftUI

struct BookDetailView: View {

    enum Constant {
        static let spacing: CGFloat = 30
    }

    @StateObject var viewModel: BookDetailViewModel
    @State var isPersist: Bool = false

    var body: some View {
        content
    }

    var content: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: Constant.spacing) {
                    
                    // Display the image
                    ImageView(withURL: viewModel.book.formats.safeImageURL())
                        .frame(width: 300, height: 300)
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 5, y: 5)
                    
                    // Display tags for subjects
                    TagsView(tags: viewModel.book.subjects)

                    // VStack for title, author, and dates
                    VStack(alignment: .leading) {
                        // HStack for title and bookmark button
                        HStack {
                            Text(viewModel.book.title)
                                .font(.title2)
                                .padding(.bottom, 8) // Optional padding for spacing

                            Spacer()

                            // Bookmark button
                            Button(action: {
                                handleDataPersistence(item: viewModel.book)
                            }, label: {
                                Image(systemName: isPersist ? "bookmark.fill" : "bookmark")
                                    .font(.system(size: 30))
                                    .foregroundColor(.yellow)
                            })
                        }
                        
                        // Author section
                        if let author = viewModel.getAuthorsIfExist() {
                            Text("Author: \(author)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.top, 8) // Add top padding for separation
                        }
                        
                        // Birth and death dates
                        Text(viewModel.getAuthorBirthDeathDate())
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // Subjects section
                    if !viewModel.book.subjects.isEmpty {
                        Text("Subjects: \(viewModel.book.subjects.joined(separator: ", "))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 8) // Add top padding for separation
                    }

                    Spacer()
                }
                .padding()
                .onAppear {
                    self.isPersist = viewModel.checkIfItemExist(viewModel.book)
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarColor(backgroundColor: .alpineGoat, titleColor: .black)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.book.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .truncationMode(.tail)
            }
        }
    }
    
    func handleDataPersistence(item: Book) {
        if isPersist {
            isPersist = false
            viewModel.deleteFromFavorites(item)
        } else {
            isPersist = true
            viewModel.addToFavorites(item)
        }
    }
}
