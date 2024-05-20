//
//  ReviewOperations.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 8.05.2024.
//

import Foundation
import FirebaseFirestore

func addReview(targetBook: Book, reviewToAdd: Review, completion: @escaping (Bool, Error?) -> Void) {
    searchBook(byField: "isbn", value: targetBook.isbn) { result in
        switch result {
        case .success(let bookId):
            reviewToAdd.bookID = bookId

            
            db.collection("reviews").addDocument(data: [
                "reviewText": reviewToAdd.reviewText,
                "stars": reviewToAdd.stars,
                "bookID": reviewToAdd.bookID,
                "username": reviewToAdd.username
            ]) { error in
                if let error = error {
                    completion(false, error)
                } else {
                    completion(true, nil)
                }
            }
        case .failure(let error):
            completion(false, error)
        }
    }
}

func removeReview(reviewID: String, completion: @escaping (Bool, Error?) -> Void) {

    db.collection("reviews").document(reviewID).delete() { error in
        if let error = error {
            completion(false, error)
        } else {
            completion(true, nil)
        }
    }
}

func editReview(reviewID: String, newReviewText: String, newStars: Int, completion: @escaping (Bool, Error?) -> Void) {

    let reviewData: [String: Any] = [
        "reviewText": newReviewText,
        "stars": newStars
    ]
    
    db.collection("reviews").document(reviewID).updateData(reviewData) { error in
        if let error = error {
            completion(false, error)
        } else {
            completion(true, nil)
        }
    }
}

