//
//  DBService+Comment.swift
//  Hype Post App
//
//  Created by C4Q on 2/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase
extension DBService {
    
    
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
    
    public func newComment(text: String, postID: String) {
        guard let uID = AuthUserService.getCurrentUser()?.uid else {print("could not get current user"); return}
        let ref = commentsRef.childByAutoId()
        let comment = Comment(commentID: ref.key, uID: uID, postID: postID, text: text)
        ref.setValue(["postID": postID,
                      "commentID": comment.commentID,
                      "uID": comment.uID,
                      "text": comment.text])
    }
    
    
}
