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
                let flags = postObject["flags"] as? UInt,
                let upVoted = postObject["upVoted"] as? Bool,
                let downVoted = postObject["downVoted"] as? Bool
                    else { print("error getting posts");return}
                
                let imageURL = postObject["imageURL"] as? String
               
                let thisPost = Post(header: header, body: body, postID: postID, uID: uID, imageURL: imageURL, time: time, downVotes: downVotes, upVotes: upVotes, flags: flags, upVoted: upVoted, downVoted: downVoted)
                posts.append(thisPost)

            }
            DBService.manager.posts = posts
            completion(posts)
        }
    }
    
    func getCurrentUserPosts() -> [Post] {
        guard let userId = AuthUserService.getCurrentUser()?.uid else { return []}
        return posts.filter{ $0.uID ==  userId}
    }

    //func below gets posts from a certain user using filter by ID
//    func getPostsByID() {
//        getAllPosts { (allPosts) in
//            guard let userId = AuthUserService.getCurrentUser()?.uid else { print("userId is nil"); return }
//            let userPosts = allPosts.filter({$0.uID == userId})
//            self.delegate?.getPostsFromUsers?(self, posts: userPosts)
//        }
//    }
    
    

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
                          "time": post.time,
                          "upVoted": post.upVoted,
                          "downVoted": post.downVoted
                          
                ])
            
            StorageService.manager.storePostImage(image: image, postID: post.postID)
            
            
            
    }
    
    
    public func upVotePost(postID: String, likedByUID uID: String) {
        let ref = postsRef.child(postID)
        ref.runTransactionBlock { (mutableData) -> TransactionResult in
            if var postObject = mutableData.value as? [String: Any] {
                var upVotesDict = postObject["upVotedBy"] as? [String: Any] ?? ["no":"data"]
                var downVotesDict = postObject["downVotedBy"] as? [String: Any] ?? ["no":"data"]
                var upVotes = postObject["upVotes"] as? Int ?? 0
                var downVotes = postObject["downVotes"] as? Int ?? 0
                
                
                if upVotesDict[uID] as? Bool == true{
                    print(upVotes)
                    upVotes -= 1
                    upVotesDict[uID] = false
                    self.delegate?.didUndoUpvote?(self)
                } else {
                    print(upVotes)
                    upVotes += 1
                    upVotesDict[uID] = true
                    print(upVotes)
                    
                    
                    if downVotesDict[uID] != nil {
                        downVotes -= 1
                        downVotesDict.removeValue(forKey: uID)
                        self.delegate?.didUndoDonwnvote?(self)
                    }
                    self.delegate?.didUpvotePost?(self)
                }
                
                postObject["upVotedBy"] = upVotesDict
                postObject["downVotedBy"] = downVotesDict
                postObject["upVotes"] = upVotes
                postObject["downVotes"] = downVotes
                mutableData.value = postObject
                return TransactionResult.success(withValue: mutableData)
            
            }
            return TransactionResult.success(withValue: mutableData)
        }
    }
    
    
    public func downVotePost(postID: String, likedByUID uID: String) {
        let ref = postsRef.child(postID)
        ref.runTransactionBlock { (mutableData) -> TransactionResult in
            if var postObject = mutableData.value as? [String: Any] {
                var upVotesDict = postObject["upVotedBy"] as? [String: Any] ?? ["no":"data"]
                var downVotesDict = postObject["downVotedBy"] as? [String: Any] ?? ["no":"data"]
                var upVotes = postObject["upVotes"] as? Int ?? 0
                var downVotes = postObject["downVotes"] as? Int ?? 0
                if downVotesDict[uID] != nil {
                    downVotes -= 1
                    downVotesDict.removeValue(forKey: uID)
                    self.delegate?.didUndoDonwnvote?(self)
                } else {
                    downVotes += 1
                    downVotesDict[uID] = true
                    
                    if upVotesDict[uID] != nil {
                        upVotes -= 1
                        upVotesDict.removeValue(forKey: uID)
                        self.delegate?.didUndoDonwnvote?(self)
                    }
                    self.delegate?.didDownvotePost?(self)
                }
                postObject["upVotedBy"] = upVotesDict
                postObject["downVotedBy"] = downVotesDict
                postObject["upVotes"] = upVotes
                postObject["downVotes"] = downVotes
                mutableData.value = postObject
                return TransactionResult.success(withValue: mutableData)
                
            }
            return TransactionResult.success(withValue: mutableData)
        }
    }
    
    public func flagPost(postID: String, userFlaggedById uID: String) {
        let ref = postsRef.child(postID)
        
        ref.runTransactionBlock { (mutableData) -> TransactionResult in
            if var postObject = mutableData.value as? [String: Any] {
                var flaggedDict = postObject["flaggedBy"] as? [String:Any] ?? ["no":"data"]
                var flags = postObject["flags"] as? UInt ?? 0
                if flaggedDict[uID] != nil {
                    print("this post has been flagged before")
                } else {
                    flaggedDict[uID] = true
                    flags += 1
                    self.delegate?.didFlagUser?(self)
                }
                postObject["flaggedBy"] = flaggedDict
                postObject["flags"] = flags
                mutableData.value = postObject
                return TransactionResult.success(withValue: mutableData)
            }
            return TransactionResult.success(withValue: mutableData)
        }
    }
    
    public func addImageToPost(url: String, postID: String) {
        addImage(url: url, ref: postsRef, id: postID)
    }
    
    public func deletePost(with postID: String) {
        postsRef.child(postID).removeValue()
        self.delegate?.didDeletePost!(self)
    }
    
}

extension Array where Element == Post {
    func sortedByUpVotes() -> [Post] {
        return self.sorted(by: { (post1, post2) -> Bool in
            let netVotesOfPost1 = post1.upVotes - post1.downVotes
            let netVotesOfPost2 = post2.upVotes - post2.downVotes
            return netVotesOfPost1 > netVotesOfPost2
        })
    }
}

