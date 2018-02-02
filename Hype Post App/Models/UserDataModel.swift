//
//  UserDataModel.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase
class User {
    let email: String
    let postCount: Int
    let userID: String
    let firstName: String
    let lastName: String
    let userName: String
    init(email: String, postCount: Int, userID: String, firstName: String, lastName: String, userName: String) {
        self.email = email; self.postCount = postCount; self.userID = userID; self.firstName = firstName; self.lastName = lastName; self.userName = userName
    }
    convenience init(email: String, userID: String, firstName: String, lastName: String) {
        self.init(email: email, userID: userID, firstName: firstName, lastName: lastName)
        //This crashes for some reason 
    }
}

class UserDataModel {
    private init() {}
    static let manager = UserDataModel()
    static let rootRef = Database.database().reference()

    static let postsRef = UserDataModel.rootRef.child("Posts")




    static private var allPosts = [Post]()
    
    static func addNewPost(post: Post, by user: User) {
        let postToAdd = Post(header: post.header, body: post.body, byUser: user.userName, postID: post.postID)
        let postRef = postsRef.child(postToAdd.postID)
        postRef.setValue(postToAdd.toAnyObject())
        allPosts.append(postToAdd)
        
    }
    
   
  
    //TO DO implement Firebase
}
