//
//  Review.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 8.05.2024.
//

import Foundation

class Review
{
    var reviewText:String
    var stars:Int
    var bookID:String
    var username:String
    
    init(reviewText: String, stars: Int, bookID: String, username: String) {
        self.reviewText = reviewText
        self.stars = stars
        self.bookID = bookID
        self.username = username
    }
    
}
