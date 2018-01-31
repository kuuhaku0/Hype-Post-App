//
//  Post.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase
class Post: Codable {
    var header: String = ""
    var body: String = ""
    var key: String = ""
    let upVotes: Int = 0
    let downVotes: Int = 0
    let byUser: String 
    let postID: String
    init(header: String, body: String, byUser: String, postID: String) {
        self.header = header; self.body = body; self.byUser = byUser; self.postID = postID
    }
     init(snapShot: DataSnapshot) {
        key = snapShot.key
        let snapShotValue = snapShot.value as! [String: AnyObject]
        header = snapShotValue["header"] as! String
        body = snapShotValue["body"] as! String
        byUser = snapShotValue["by User"] as! String
        postID = snapShotValue["postID"] as! String
    }
    func toAnyObject() -> Any {
        return [
            "header": header,
            "body": body,
            "by User": byUser,
            "postID": postID
            
        ]
    }
    
}




