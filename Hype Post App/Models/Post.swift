//
//  Post.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Post: NSObject, Codable {
    var header: String = ""
    var body: String = ""
    let uID: String //auth.auth.getcurrentUser.uid
    let upVotes: Int = 0
    let downVotes: Int = 0

    let postID: String
    var imageURL: String?
    init(header: String, body: String, postID: String, uID: String, imageURL: String?) {
        self.header = header; self.body = body;  self.postID = postID; self.uID = uID; self.imageURL = imageURL ?? ""
    }
    init (header: String, body: String, postID: String, uID: String) {
        self.header = header; self.body = body;  self.postID = postID; self.uID = uID
        self.imageURL = ""
    }
    let time: String
    let postID: String
    


}




