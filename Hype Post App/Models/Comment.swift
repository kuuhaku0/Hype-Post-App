//
//  Comment.swift
//  Hype Post App
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
class Comment {
    let commentID: String
    let byUser: String
    let postID: String
    let text: String
    var upVotes: Int = 0
    var downVotes: Int = 0
    init (commentID: String, byUser: String, postID: String, text: String) {
        self.commentID = commentID; self.byUser = byUser; self.postID = postID; self.text = text
    }
}
