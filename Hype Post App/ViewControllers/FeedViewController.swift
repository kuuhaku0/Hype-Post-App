//
//  FeedViewController.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    
    var posts = [Post]()
    var postsRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        postsRef = Database.database().reference().child("posts")
        addNewPost()
        feedTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedCell")
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.separatorStyle = .none
        feedTableView.backgroundColor = .white
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        return cell
    }
}

extension FeedViewController {
    
    func addNewPost() {
        let key = postsRef.childByAutoId().key
        let post = ["id" : key, "title": "Test Post", "body": "test text", "user": "this user"]
        
        postsRef.child(key).setValue(post)
        
        postsRef.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.posts.removeAll()
                for posts in snapshot.children.allObjects as! [DataSnapshot] {
                    let postObj = posts.value as? [String: AnyObject]
                    let postTitle = postObj?["title"]
                    let postBody = postObj?["body"]
                    let postedBy = postObj?["user"]
                    let postID = postObj?["id"]
                    let post = Post.init(header: postTitle as! String, body: postBody as! String, byUser: postedBy as! String, postID: postID as! String)
                    
                    self.posts.append(post)
                }
                //RELOAD TABLEVIEW
            }
        }
    }
}

