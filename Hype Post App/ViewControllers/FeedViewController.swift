//
//  FeedViewController.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase
import Material
import SnapKit

class FeedViewController: UIViewController {
    
    lazy var createPostButton: FABButton = {
        let button = FABButton(image: Icon.cm.add)
        button.tintColor = .white
        button.pulseColor = .white
        button.backgroundColor = Color.red.base
        return button
    }()
    
    func setupCPB() {
        createPostButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
        }
    }
    
    @IBOutlet weak var feedTableView: UITableView!
    
    var posts = [Post]() {
        didSet {
            feedTableView.reloadData()
        }
    }
    var postsRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createPostButton)
        view.layout(createPostButton).width(55).height(55)
        setupCPB()
        prepareTabItem()
        feedTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedCell")
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.separatorStyle = .none
        DBService.manager.newPost(header: "sadfasdf", body: "sdfgsdfg", by: AppUser.init(email: "asdfasdfd", userName: "sdfgsdfg", firstName: "sdfgdsfg", lastName: "dsfgsdf"))
        loadData()
    }
    
    func loadData() {
        DBService.manager.getAllPosts { (posts) in
            self.posts = posts
        }
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    public static func storyboardInstance() -> FeedViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let feedViewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        return feedViewController
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]
        cell.configureCell(post: post)
        //TO DO: CREATE A FUNCTION TO SET UP CELL
        return cell
    }
}

extension FeedViewController {
        fileprivate func prepareTabItem() {
            tabItem.title = "r e c e n t"
            
        }
}

