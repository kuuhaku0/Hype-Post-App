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
    var upVotes: Int = 0
    var downVotes: Int = 0
    var time: Double  = Date.timeIntervalSinceReferenceDate
    var flags: UInt = 0

    let postID: String
    var imageURL: String?
    init(header: String, body: String, postID: String, uID: String, imageURL: String?, time: Double, downVotes: Int, upVotes: Int, flags: UInt) {
        self.header = header; self.body = body;  self.postID = postID; self.uID = uID; self.imageURL = imageURL ?? ""; self.time = time; self.upVotes = upVotes; self.downVotes = downVotes; self.flags = flags
    }
    init (header: String, body: String, postID: String, uID: String) {
        self.header = header; self.body = body;  self.postID = postID; self.uID = uID
        self.imageURL = ""
    }
}




