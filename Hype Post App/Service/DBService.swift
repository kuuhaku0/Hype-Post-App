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
    
    @objc optional func didUpvotePost(_ databaseService: DBService)
    
    @objc optional func didDownvotePost(_ databaseService: DBService)
    
     @objc optional func didUndoUpvote(_ databaseService: DBService)
    
    @objc optional func didUndoDonwnvote(_ databaseService: DBService)
    
    @objc optional func didFlagPost(_ databaseService: DBService)
    
    @objc optional func didFlagUser(_ databaseService: DBService)
    
    @objc optional func didComment(_databaseService: DBService)
    
    @objc optional func getCommentsFromPost(_ DBService:DBService, comments: [Comment])
    
     @objc optional func didDeletePost(_ databaseService: DBService)
    
     @objc optional func didDeleteComment(_ databaseService: DBService)
    
    
    
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
    
     var posts = [Post]()
     var comments = [Comment]()

    
     var rootRef: DatabaseReference!
     var usersRef: DatabaseReference!
     var postsRef: DatabaseReference!
     var commentsRef: DatabaseReference!
 
    public weak var delegate: DBServiceDelegate?
    
    public func addImage(url: String, ref: DatabaseReference, id: String) {
        ref.child(id).child("imageURL").setValue(url)
        
    }
    

}
