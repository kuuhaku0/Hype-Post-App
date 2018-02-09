//
//  DBService+Comment.swift
//  Hype Post App
//
//  Created by C4Q on 2/5/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase
extension DBService {
    
    func getAllComments(completion: @escaping (_ comments: [Comment]) -> Void) {
        commentsRef.observe(.value) { (dataSnapshot) in
            var comments: [Comment] = []
            guard let commentSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for commentSnapshot in commentSnapshots {
                guard let commentObject = commentSnapshot.value as? [String: Any] else {return}
                guard let commentID = commentObject["commentID"] as? String,
                    let postID = commentObject["postID"] as? String,
                    let text = commentObject["text"] as? String,
                    let uID = commentObject["uID"] as? String,
                    let time = commentObject["time"] as? Double,
                    let upVotes = commentObject["upVotes"] as? Int,
                    let downVotes = commentObject["downVotes"] as? Int,
                    let flags = commentObject["flags"] as? UInt
                    
                    else {print("error getting comments");return}
                
                let thisComment = Comment(commentID: commentID, uID: uID, postID: postID, text: text, upVotes: upVotes, downVotes: downVotes, time: time, flags: flags)
                comments.append(thisComment)
                
            }
            DBService.manager.comments = comments
            completion(comments)
        }
    }
    
    func getCurrentUserComments() -> [Comment] {
        guard let userID = AuthUserService.getCurrentUser()?.uid else {
            print("cant get current users comments"); return []
        }
        return comments.filter({$0.uID == userID})
    }
    
    func getCommentsFromPost(from certainPostID: String, completion: @escaping (_ comments: [Comment]) -> Void) {
        commentsRef.observe(.value) { (dataSnapshots) in
            guard let commentData = dataSnapshots.children.allObjects as? [DataSnapshot] else {return}
            var comments = [Comment]()
            for commentSnapshot in commentData {
                print(commentData)
                guard let commentObject = commentSnapshot.value as? [String:Any] else {return}
                
                guard let commentID = commentObject["commentID"] as? String,
                    let postID = commentObject["postID"] as? String,
                    let text = commentObject["text"] as? String,
                    let uID = commentObject["uID"] as? String,
                    let time = commentObject["time"] as? Double,
                    let upVotes = commentObject["upVotes"] as? Int,
                   let downVotes = commentObject["downVotes"] as? Int,
                  let flags = commentObject["flags"] as? UInt
                    else {return}
                
                if postID != certainPostID {
                    continue
                }
                let thisComment = Comment(commentID: commentID, uID: uID, postID: postID, text: text, upVotes: upVotes, downVotes: downVotes, time: time, flags: flags)
                comments.append(thisComment)
            }
            completion(comments)
            
        }
    }
    
    public func getCommentsFromUser(from certainUID: String, completion: @escaping (_ comments: [Comment]) -> Void) {
        commentsRef.observe(.value) { (dataSnapshots) in
            guard let commentData = dataSnapshots.children.allObjects as? [DataSnapshot] else {return}
            var comments = [Comment]()
            for commentSnapshot in commentData {
                guard let commentObject = commentSnapshot.value as? [String:Any] else {return}
                
                guard let commentID = commentObject["commentID"] as? String,
                    let postID = commentObject["postID"] as? String,
                    let text = commentObject["text"] as? String,
                    let uID = commentObject["uID"] as? String,
                    let time = commentObject["time"] as? Double,
                    let upVotes = commentObject["upVotes"] as? Int,
                    let downVotes = commentObject["downVotes"] as? Int,
                    let flags = commentObject["flags"] as? UInt
                    
                    else {return}
                
                if uID != certainUID {
                    continue
                }
                let thisComment = Comment(commentID: commentID, uID: uID, postID: postID, text: text, upVotes: upVotes, downVotes: downVotes, time: time, flags: flags)
                comments.append(thisComment)
            }
            completion(comments)
            
        }
    }
    
    public func newComment(text: String, postID: String) {
        guard let uID = AuthUserService.getCurrentUser()?.uid else {print("could not get current user"); return}
        let ref = commentsRef.childByAutoId()
        let comment = Comment(commentID: ref.key, uID: uID, postID: postID, text: text)
        ref.setValue(["postID": postID,
                      "commentID": comment.commentID,
                      "uID": comment.uID,
                      "text": comment.text,
                      "time": comment.time,
                      "upVotes": comment.upVotes,
                      "downVotes": comment.downVotes,
                      "flags": comment.flags])
        print("new comment added")
    }
    
    public func deleteComment(with commentID: String) {
        commentsRef.child(commentID).removeValue()
        self.delegate?.didDeleteComment!(self)
    }
    
}
