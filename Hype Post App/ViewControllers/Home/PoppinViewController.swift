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
//        tableView.register(DynamicPopularTableViewCell.self, forCellReuseIdentifier: "PopularCell")
        prepareTabItem()
    }
    
    
    public static func storyboardInstance() -> PoppinViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let poppinVC = storyboard.instantiateViewController(withIdentifier: "PoppinViewController") as! PoppinViewController
        return poppinVC
    }
    
    private func loadData() {
        DBService.manager.getAllPosts { (posts) in
            self.posts = posts.sortedByUpVotes()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as! DynamicPopularTableViewCell
        let post = self.posts[indexPath.row]
        print("IN TABLEVIEW:\(post.byUser)")
        cell.configureCell(post: post)
        cell.delegate = self
        if let imgURL = post.imageURL {
            let img1str = imgURL
            let url1 = URL(string: img1str)
            cell.postImage.kf.setImage(with: url1) { (image, error, cache, url) in
                if let image = image {
                    let ratio = image.size.width / image.size.height
                    if ratio > 1 {
                        let newHeight = cell.frame.width / ratio
                        cell.postImage.bounds.size = CGSize(width: cell.frame.width, height: newHeight)
                        self.refreshTableView()
                    } else {
                        let newWidth = cell.frame.height * ratio
                        cell.postImage.frame.size = CGSize(width: newWidth, height: cell.frame.height)
                        self.refreshTableView()
                    }
                }
            }
        }
        
        return cell
    }
}

extension PoppinViewController{
        fileprivate func prepareTabItem() {
            tabItem.title = "poppin'"
        }
}

extension PoppinViewController: DynamicPopularTableViewCellDelegate {
    func refreshTableView() {
        tableView.beginUpdates()
        tableView.setNeedsDisplay()
        tableView.endUpdates()
    }
    
    func dynamicPopularTableViewCellDislikedPist(_ sender: DynamicPopularTableViewCell ) {
        
    }
    
    func dynamicPopularTableViewCellCommentPressed(_ sender: DynamicPopularTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        let post = posts[tappedIndexPath.row]
        let vc = AddCommentViewController(post: post)
        vc.modalPresentationStyle = .currentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true) {}
    }
    
    func dynamicPopularTableViewCellLikedPost(_ sender: DynamicPopularTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        let post = posts[tappedIndexPath.row]
        if let currentUser = AuthUserService.getCurrentUser(){
            DBService.manager.upVotePost(postID: post.postID, likedByUID: currentUser.uid)
            tableView.reloadRows(at: [tableView.indexPath(for: sender)!], with: .none)
        }
    }
    
    
    func dynamicPopularTableViewCellDidFlagPost(_ sender: DynamicPopularTableViewCell) {
        
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        let post = posts[tappedIndexPath.row]
        if let currentUser = AuthUserService.getCurrentUser(){
            DBService.manager.flagPost(postID: post.postID, userFlaggedById: currentUser.uid)
        }
    }
}
