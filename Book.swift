//
//  Book.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 3.05.2024.
//

import Foundation


class Book
{
    var name:String
    var author:String
    var genre:String
    var isbn:String
    var year:Int?
    
    init()
    {
        self.name="Unknown"
        self.author="Unknown"
        self.genre="Unknown"
        self.isbn="Unknown"
        self.year=nil
    }
    
    init(newName:String,newAuthor:String,newGenre:String,newISBN:String,newYear:Int?)
    {
        self.name=newName
        self.author=newAuthor
        self.genre=newGenre
        self.isbn=newISBN
        self.year=newYear
    }
    
    func description()->String
    {
        return "Book name: \(name) Book Author: \(author)\nBook genre:\(genre) Year published:\(year)\nbook ISBN:\(isbn)\n"
    }
    
}
