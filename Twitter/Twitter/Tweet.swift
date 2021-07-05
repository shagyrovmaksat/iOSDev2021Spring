//
//  Tweet.swift
//  Twitter
//
//  Created by Shagirov Maksat on 16.04.2021.
//

import Foundation
import FirebaseDatabase

struct Tweet {
    var content : String?
    var author : String?
    var date : String?
    var hashtag : String?
    
    var dict : [String : String] {
        return [
            "content" : content!,
            "author" : author!,
            "date" : date!,
            "hashtag" : hashtag!
        ]
    }
    
    init(_ content : String, _ author : String, _ date : String, _ hashtag : String) {
        self.content = content
        self.author = author
        self.date = date
        self.hashtag = hashtag
    }
    
    init(snapshot : DataSnapshot) {
        if let value = snapshot.value as? [String : String] {
            content = value["content"]
            author = value["author"]
            date = value["date"]
            hashtag = value["hashtag"]
        }
    }
}
