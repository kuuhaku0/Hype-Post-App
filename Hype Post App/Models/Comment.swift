//
//  Comment.swift
//  Hype Post App
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
class Comment: NSObject {
    let commentID: String
    let uID: String
    let postID: String
    let text: String
    var upVotes: Int = 0
    var downVotes: Int = 0
    var flags: UInt = 0
    var time: Double = Date.timeIntervalSinceReferenceDate
    var userName: String
    init(commentID: String, uID: String, postID: String, text: String, upVotes: Int, downVotes: Int, time: Double, flags: UInt, userName: String) {
        self.commentID = commentID; self.uID = uID; self.postID = postID; self.text = text; self.upVotes = upVotes; self.downVotes = downVotes; self.time = time; self.flags = flags; self.userName = userName
    }
    init (commentID: String, uID: String, postID: String, text: String, userName: String) {
        self.commentID = commentID; self.uID = uID; self.postID = postID; self.text = text; self.userName = userName
    }
}
