//
//  ReviewDetailView.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 8.05.2024.
//

import SwiftUI

struct ReviewDetailView: View {
    let bookID: String
    let bookName: String
    @State private var reviews: [Review] = []

    var body: some View {
        VStack {
            if reviews.isEmpty {
                Text("No reviews for this book yet.😢")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(reviews, id: \.identifier) { review in
                    VStack(alignment: .leading) {
                        Text(review.username)
                            .font(.headline)
                        Text(review.reviewText)
                            .font(.body)
                        Text("Stars: \(review.stars)")
                            .font(.subheadline)
                    }
                }
            }
        }
        .onAppear {
            fetchReviews()
        }
        .navigationTitle(bookName)
    }

    private func fetchReviews() {
        fetchReviewsByBookID(bookID: bookID) { result in
            switch result {
            case .success(let fetchedReviews):
                reviews = fetchedReviews
            case .failure(let error):
                print("Error fetching reviews: \(error.localizedDescription)")
                reviews = []  // Ensure reviews array is empty on failure
            }
        }
    }
}

extension Review {
    var identifier: String {
        "\(username)-\(reviewText)-\(bookID)"
    }
}



struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView(
            bookID: "dummyBookID",
            bookName: "Sample Book"
        )
    }
}

