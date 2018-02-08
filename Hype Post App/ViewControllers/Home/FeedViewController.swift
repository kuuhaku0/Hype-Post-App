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
import Kingfisher
import SDWebImage

class FeedViewController: UIViewController {
  
    lazy var createPostButton: FABButton = {
        let button = FABButton(image: Icon.cm.add)
        button.tintColor = .white
        button.pulseColor = .white
        button.backgroundColor = Color.gray
        button.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        return button
    }()
    
    func setupCPB() {
        createPostButton.snp.makeConstraints { (make) in
        make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
        }
    }
    
    @objc func createPost() {
        let createPostVC = CreatePostViewController.storyboardInstance()
        self.present(createPostVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var feedTableView: UITableView! {
        didSet {
            feedTableView.estimatedRowHeight = 100
        }
    }

    public var posts = [Post]() {
        didSet {
            recentPosts = posts.reversed()
            feedTableView.reloadData()
        }
    }
    
    public var recentPosts = [Post](){
        didSet  {
            feedTableView.reloadData()
        }
    }
    
    var postsRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(createPostButton)
        view.layout(createPostButton).width(55).height(55)
        setupCPB()
        loadData()
       let user = AuthUserService.getCurrentUser()
        print(user?.displayName)
        prepareTabItem()
        feedTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedCell")
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.separatorStyle = .none
        feedTableView.backgroundColor = Color.grey.lighten4
    }
    
    override func viewDidLayoutSubviews() {
        constrainTableView()
    }
    
    func loadData() {
        DBService.manager.getAllPosts { (posts) in
            self.posts = posts.reversed()
        }
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
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
        cell.delegate = self
        
//        cell.clipsToBounds = true
//        if let imgURL = post.imageURL {
//            let img1str = imgURL
//            let url1 = URL(string: img1str)
//
//            cell.postImage.sd_setImage(with: url1) { (image, error, cache, url) in
//                if let image = image {
//                    let ratio = image.size.width / image.size.height
//                    if ratio > 1 {
//                        let newHeight = cell.frame.width * 0.8 / ratio
//                        cell.postImage.bounds.size = CGSize(width: cell.frame.width, height: newHeight)
//                    } else {
//                        let newWidth = cell.frame.height * ratio
//                        cell.postImage.frame.size = CGSize(width: newWidth, height: cell.frame.height)
//                    }
//                }
//            }
//        }
        return cell
    }
}

extension FeedViewController: FeedTableViewCellDelegate {
    func feedTableViewCellCommentPressed(_ sender: FeedTableViewCell) {
        
        guard let tappedIndexPath = feedTableView.indexPath(for: sender) else { return }
        let post = posts[tappedIndexPath.row]
        let vc = AddCommentViewController(post: post)
        vc.modalPresentationStyle = .currentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true) {}
    }
    
    func feedTableViewCellLikedPost(_ sender: FeedTableViewCell) {
        guard let tappedIndexPath = feedTableView.indexPath(for: sender) else { return }
        let post = posts[tappedIndexPath.row]
        if let currentUser = AuthUserService.getCurrentUser(){
            DBService.manager.upVotePost(postID: post.postID, likedByUID: currentUser.uid)
//            feedTableView.reloadRows(at: [feedTableView.indexPath(for: sender)!], with: .none)
        }
    }
    
    
    func feedTableViewCellDidFlagPost(_ sender: FeedTableViewCell) {
       
        guard let tappedIndexPath = feedTableView.indexPath(for: sender) else { return }
        let post = recentPosts[tappedIndexPath.row]
        if let currentUser = AuthUserService.getCurrentUser(){
        DBService.manager.flagPost(postID: post.postID, userFlaggedById: currentUser.uid)
        }
    }
}

extension FeedViewController {
    
    fileprivate func constrainTableView(){
        feedTableView.snp.makeConstraints { (make) in
            make.top.equalTo((tabsController?.tabBar.snp.bottom)!)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    fileprivate func prepareTabItem() {
        tabItem.title = "recent"
    }
}

