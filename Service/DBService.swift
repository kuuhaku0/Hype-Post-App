//
//  DBService.swift
//  firebase stuff
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

@objc protocol DBServiceDelegate: class {
    @objc optional func getPostsFromUsers(_ DBService:DBService, posts: [Post])
    
    @objc optional func didFailGettingUserPosts(_ databaseService: DBService, error: String)
}

class DBService: NSObject {
    
    private override init() {
        
        rootRef = Database.database().reference()
        usersRef = rootRef.child("users")
        postsRef = rootRef.child("posts")
        commentsRef = rootRef.child("comments")
        super.init()
    
    }
    
    static let manager = DBService()
    
     var rootRef: DatabaseReference!
     var usersRef: DatabaseReference!
     var postsRef: DatabaseReference!
     var commentsRef: DatabaseReference!
 
    public weak var delegate: DBServiceDelegate?
    

}
