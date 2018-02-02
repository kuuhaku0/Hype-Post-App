//
//  DBService+Jobs.swift
//  firebase stuff
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DBService {

    func getAppUser(with uID: String, completion: @escaping (_ user: AppUser) -> Void) {
        let userRef = usersRef.child(uID)
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let email = snapshot.childSnapshot(forPath: "email").value as? String else {return}
            guard let userName = snapshot.childSnapshot(forPath: "userName").value as? String else {return}
            let currentAppUser = AppUser(email: email, uID: uID, userName: userName)
            completion(currentAppUser)
        }
    }
    
    //Func below gets all the posts using a completion handler
    public func getAllPosts(completion: @escaping (_ posts: [Post]) -> Void) {
        postsRef.observe(.value) { (dataSnapshot) in
            var posts: [Post] = []
            guard let postSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for postSnapshot in postSnapshots {
                guard let postObject = postSnapshot.value as? [String: Any] else {
                    return
                }
                guard let header = postObject["header"] as? String,
                let body = postObject["body"] as? String,
                let uID = postObject["uID"] as? String,
                let postID = postObject["postID"] as? String
                    else { print("error getting posts");return}
                
                let thisPost = Post(header: header, body: body, postID: postID, uID: uID)
                posts.append(thisPost)
            }
            completion(posts)
    
    
        }
        
}
    //func below gets posts from a certain user using filter by ID
    func getPostsByID(from uID: String) {
        getAllPosts { (allPosts) in
            let userPosts = allPosts.filter({$0.uID == uID})
            self.delegate?.getPostsFromUsers?(self, posts: userPosts)
        }
    }
    
    func getComments(from certainPostID: String, completion: @escaping (_ comments: [Comment]) -> Void) {
        commentsRef.observe(.value) { (dataSnapshots) in
            guard let commentData = dataSnapshots.children.allObjects as? [DataSnapshot] else {return}
            var comments = [Comment]()
            for commentSnapshot in commentData {
                guard let commentObject = commentSnapshot.value as? [String:Any] else {return}
                
                guard let commentID = commentObject["commentID"] as? String,
                let postID = commentObject["postID"] as? String,
                let text = commentObject["text"] as? String,
                let uID = commentObject["uID"] as? String
                else {return}
                
                if postID != certainPostID {
                    continue
                }
                let thisComment = Comment(commentID: commentID, uID: uID, postID: postID, text: text)
                comments.append(thisComment)
            }
            completion(comments)
            
        }
    }
    
    

}
