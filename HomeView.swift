//
//  HomeView.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 5.05.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = BooksViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(zip(viewModel.books.indices, viewModel.books)), id: \.1.isbn) { index, book in
                    NavigationLink(destination: ReviewDetailView(bookID: viewModel.bookDocumentIDs[index], bookName: book.name)) {
                        VStack(alignment: .leading) {
                            Text(book.name)
                                .font(.headline)
                            Text("Author: \(book.author)")
                            Text("Genre: \(book.genre)")
                            Text("ISBN: \(book.isbn)")
                            if let year = book.year {
                                Text("Year: \(year)")
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchBooks()
            }
            .navigationTitle("Books")
        }
    }
}
