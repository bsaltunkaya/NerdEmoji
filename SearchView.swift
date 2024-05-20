//
//  SearchView.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 6.05.2024.
//

import SwiftUI

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults: [Book] = []
    @State private var isSearching = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter exact book name...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onSubmit {
                        fetchBooks()
                    }

                if isSearching {
                    ProgressView()
                } else {
                    List(searchResults, id: \.isbn) { book in
                        VStack(alignment: .leading) {
                            Text(book.name).font(.headline)
                            Text("Author: \(book.author)")
                            Text("Genre: \(book.genre)")
                            if let year = book.year {
                                Text("Year: \(year)")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Search Books")
        }
    }

    func fetchBooks() {
        isSearching = true
        searchBooksByName(query: searchText) { result in
            DispatchQueue.main.async {
                isSearching = false
                switch result {
                case .success(let books):
                    searchResults = books
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    searchResults = []
                }
            }
        }
    }
}

    
    
    #Preview {
        SearchView()
    }


