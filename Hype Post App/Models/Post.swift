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
    let uID: String
    let upVotes: Int = 0
    let downVotes: Int = 0
    let time: String
    let postID: String
    
    init(header: String, body: String, postID: String, uID: String, time: String) {
        self.header = header; self.body = body;  self.postID = postID; self.uID = uID; self.time = time
    }
//     init(snapShot: DataSnapshot) {
//        let snapShotValue = snapShot.value as! [String: AnyObject]
//        header = snapShotValue["header"] as! String
//        body = snapShotValue["body"] as! String
//        
//        postID = snapShotValue["postID"] as! String
//    }
}




