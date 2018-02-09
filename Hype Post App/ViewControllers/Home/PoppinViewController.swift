//
//  PoppinViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class PoppinViewController: UIViewController {
    
    var posts = [Post]() {
        didSet {
            tableView.reloadData()
            print(posts)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 400
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLayoutSubviews() {
        constrainTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DynamicFeedTableViewCell.self, forCellReuseIdentifier: "PopularCell")
        prepareTabItem()
    }
    
    
    public static func storyboardInstance() -> PoppinViewController {
        let storyboard = UIStoryboard(name: "PopularPosts", bundle: nil)
        let poppinVC = storyboard.instantiateViewController(withIdentifier: "PoppinViewController") as! PoppinViewController
        return poppinVC
    }
    
    private func loadData() {
        DBService.manager.getAllPosts { (posts) in
            self.posts = posts.reversed()
            print(posts)
        }
    }
    
    fileprivate func constrainTableView(){
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo((tabsController?.tabBar.snp.bottom)!)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}

extension PoppinViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as! DynamicFeedTableViewCell
        let post = self.posts[indexPath.row]
        print("IN TABLEVIEW:\(post.byUser)")
        cell.configureCell(post: post)
        return cell
    }
}

extension PoppinViewController{
        fileprivate func prepareTabItem() {
            tabItem.title = "poppin'"
        }
}

extension PoppinViewController: DynamicFeedTableViewCellDelegate {
    func dynamicFeedTableViewCellDislikedPist(_ sender: DynamicFeedTableViewCell) {
        
    }
    
    func dynamicFeedTableViewCellCommentPressed(_ sender: DynamicFeedTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        let post = posts[tappedIndexPath.row]
        let vc = AddCommentViewController(post: post)
        vc.modalPresentationStyle = .currentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true) {}
    }
    
    func dynamicFeedTableViewCellLikedPost(_ sender: DynamicFeedTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        let post = posts[tappedIndexPath.row]
        if let currentUser = AuthUserService.getCurrentUser(){
            DBService.manager.upVotePost(postID: post.postID, likedByUID: currentUser.uid)
            tableView.reloadRows(at: [tableView.indexPath(for: sender)!], with: .none)
        }
    }
    
    
    func dynamicFeedTableViewCellDidFlagPost(_ sender: DynamicFeedTableViewCell) {
        
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        let post = posts[tappedIndexPath.row]
        if let currentUser = AuthUserService.getCurrentUser(){
            DBService.manager.flagPost(postID: post.postID, userFlaggedById: currentUser.uid)
        }
    }
}
