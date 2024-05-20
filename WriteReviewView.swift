//
//  WriteReviewView.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 6.05.2024.
//

import SwiftUI

struct WriteReviewView: View {
    @State private var reviewText: String = ""
    @State private var searchQuery: String = ""
    @State private var showSuccessMessage: Bool = false
    @State private var selectedBook: Book?
    @State private var starAmount:Int=0
    @ObservedObject var booksViewModel = BooksViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Book", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Search") {
                    searchBooks()
                }
                .padding()
                
                
                    List(booksViewModel.books, id: \.isbn) { book in
                        Text(book.name)
                            .onTapGesture {
                                selectedBook = book
                            }
                    }

                
                
                if selectedBook != nil {
                    TextEditor(text: $reviewText)
                        .padding()
                        .border(Color.gray, width: 1)
                    Text("Star rating:")
                    Picker("Star rating:", selection: $starAmount) {
                                                ForEach(1..<6) { star in
                                                    Text("\(star)").tag(star)
                                                }
                                            }
                                            .pickerStyle(SegmentedPickerStyle())
                                            .padding()
                        
                    
                    Button("Submit Review") {
                        submitReview()
                    }
                    .padding()
                    .disabled(reviewText.isEmpty)
                }
                
                if showSuccessMessage {
                    Text("✅ Submission successful!")
                        .padding()
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
        }
    }
    
    private func searchBooks() {
        searchBooksByName(query: searchQuery) { result in
            switch result {
            case .success(let books):
                booksViewModel.books = books
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func submitReview() {
        guard let book = selectedBook else { return }
        let newReview = Review(reviewText: reviewText, stars: starAmount, bookID: "", username: "Current User")
        //until auth system is implemented username is set as default: current user
        
        addReview(targetBook: book, reviewToAdd: newReview) { success, error in
            if success {
                reviewText = ""
                showSuccessMessage = true
                selectedBook = nil // Clear selected book after submitting review
                
                // Hide success message after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showSuccessMessage = false
                }
            } else if let error = error {
                print("Failed to add review: \(error.localizedDescription)")
            }
        }
    }
}
