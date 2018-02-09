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
    var time: String  = "\(Date())"
    var flags: UInt = 0
    var upVoted: Bool = false
    var downVoted: Bool = false
    let byUser: String
    var commentCount: Int = 0

    let postID: String
    var imageURL: String?
    init(header: String, body: String, postID: String, uID: String, imageURL: String?, time: String, downVotes: Int, upVotes: Int, flags: UInt, upVoted: Bool, downVoted: Bool, byUser: String, commentCount: Int) {
        self.header = header; self.body = body;  self.postID = postID; self.uID = uID; self.imageURL = imageURL ?? ""; self.time = time; self.upVotes = upVotes; self.downVotes = downVotes; self.flags = flags; self.upVoted = upVoted; self.downVoted = downVoted; self.byUser = byUser; self.commentCount = commentCount
    }
    init (header: String, body: String, postID: String, uID: String, byUser: String) {
        self.header = header; self.body = body;  self.postID = postID; self.uID = uID; self.byUser = byUser
        self.imageURL = ""
    }
}




