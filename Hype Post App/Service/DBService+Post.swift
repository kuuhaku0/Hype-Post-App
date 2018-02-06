//
//  DBService+Jobs.swift
//  firebase stuff
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension DBService {

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

                
                let upVotes = postObject["upVotes"] as? Int,
                let downVotes = postObject["downVotes"] as? Int,
                let time = postObject["time"] as? String,
                let postID = postObject["postID"] as? String,
                let flags = postObject["flags"] as? UInt
                    else { print("error getting posts");return}
                
                let imageURL = postObject["imageURL"] as? String
               
                let thisPost = Post(header: header, body: body, postID: postID, uID: uID, imageURL: imageURL, time: time, downVotes: downVotes, upVotes: upVotes, flags: flags)
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
    
    

        func newPost(header: String, body: String, image: UIImage?) {
            guard let currentUser = AuthUserService.getCurrentUser() else {print("could not get current user"); return}
            let ref = postsRef.childByAutoId()
            let post = Post(header: header, body: body, postID: ref.key, uID: currentUser.uid)
            ref.setValue(["header": post.header,
                          "body": post.body,
                          "postID": post.postID,
                          "uID": post.uID,
                          "upVotes": post.upVotes,
                          "downVotes": post.downVotes,
                          "flags": post.flags,
                          "time": post.time
                          
                ])
            
            
            
        }
        
    }

