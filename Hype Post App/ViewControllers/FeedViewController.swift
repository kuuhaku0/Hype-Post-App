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
        feedTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedCell")
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.separatorStyle = .none
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public static func storyboardInstance() -> FeedViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let feedViewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        return feedViewController
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        
        //TO DO: CREATE A FUNCTION TO SET UP CELL
        return cell
    }
}

extension FeedViewController {
    
    
}

