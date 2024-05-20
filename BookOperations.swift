//
//  BookOperations.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 5.05.2024.
//

import Foundation
import FirebaseFirestore
import Combine

let db=Firestore.firestore()

func addBook(book: Book, completion: @escaping (Bool, String?) -> Void) {
    db.collection("books").addDocument(data: [
        "name": book.name,
        "author": book.author,
        "genre": book.genre,
        "isbn": book.isbn,
        "year": book.year ?? NSNull()
    ]) { error in
        if let error = error {
            completion(false, error.localizedDescription)
        } else {
            completion(true, nil)
        }
    }
}


//exact name find function
//only exact name because firestore is lacking
func searchBooksByName(query: String, completion: @escaping (Result<[Book], Error>) -> Void) {
    db.collection("books")
        .whereField("name", isEqualTo: query)
        .getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion(.failure(error))
            } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                let books = documents.map { doc -> Book in
                    let data = doc.data()
                    let name = data["name"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let genre = data["genre"] as? String ?? ""
                    let isbn = data["isbn"] as? String ?? ""
                    let year = data["year"] as? Int
                    return Book(newName: name, newAuthor: author, newGenre: genre, newISBN: isbn, newYear: year)
                }
                completion(.success(books))
            } else {
                print("No documents found with exact name '\(query)'")
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No books found with exact name '\(query)'"])))
            }
        }
}


//function that searches for a book by a specific field and value and returns the document ID through a completion handler.
func searchBook(byField field: String, value: String, completion: @escaping (Result<String, Error>) -> Void) {
    db.collection("books").whereField(field, isEqualTo: value)
        .getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                // Assume the first document is the one we need if multiple documents have the same field value
                let documentId = documents.first!.documentID
                completion(.success(documentId))
            } else {
                // If no documents are found, return a custom error.
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No document found with \(field) equal to \(value)"])))
            }
        }
}


//bookremover
//TODO:USE
func removeBook(book: Book, completion: @escaping (Result<Void, Error>) -> Void) {
    
    searchBook(byField: "isbn", value: book.isbn) { result in
        switch result {
        case .success(let documentId):

            db.collection("books").document(documentId).delete() { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
//book fetcher for homepage view
class BooksViewModel: ObservableObject {
    @Published var books = [Book]()
    @Published var bookDocumentIDs = [String]()

    func fetchBooks() {
        let db = Firestore.firestore()
        db.collection("books").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents found in the books collection")
                return
            }

            self.books = documents.map { queryDocumentSnapshot -> Book in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let author = data["author"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let isbn = data["isbn"] as? String ?? ""
                let year = data["year"] as? Int ?? nil
                
                return Book(newName: name, newAuthor: author, newGenre: genre, newISBN: isbn, newYear: year)
            }
            self.bookDocumentIDs = documents.map { $0.documentID }
        }
    }
}

//fetcher by ID
func fetchReviewsByBookID(bookID: String, completion: @escaping (Result<[Review], Error>) -> Void) {

    db.collection("reviews").whereField("bookID", isEqualTo: bookID)
        .addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Firestore error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No reviews found for bookID: \(bookID)")
                completion(.failure(NSError(domain: "NoReviews", code: 0, userInfo: nil)))
                return
            }

            let reviews = documents.map { doc -> Review in
                let data = doc.data()
                let reviewText = data["reviewText"] as? String ?? "No review text provided"
                let stars = data["stars"] as? Int ?? 0
                let username = data["username"] as? String ?? "Anonymous"
                return Review(reviewText: reviewText, stars: stars, bookID: bookID, username: username)
            }
            print("Fetched \(reviews.count) reviews for bookID: \(bookID)")
            completion(.success(reviews))
        }
}
