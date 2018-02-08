//
//  PoppinViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class PoppinViewController: UIViewController {

    var posts = [Post]().sorted { (current, next) -> Bool in
            current.upVotes > next.upVotes
        } {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLayoutSubviews() {
        constrainTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.hidesBarsOnSwipe = true
        
        tableView.dataSource = self
        prepareTabItem()
        loadData()
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "PopularCell")
    }
    
    
    public static func storyboardInstance() -> PoppinViewController {
        let storyboard = UIStoryboard(name: "PopularPosts", bundle: nil)
        let poppinVC = storyboard.instantiateViewController(withIdentifier: "PoppinViewController") as! PoppinViewController
        return poppinVC
    }
    
    private func loadData() {
        DBService.manager.getAllPosts { (posts) in
            self.posts = posts
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

extension PoppinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]
        cell.configureCell(post: post)
        return cell
    }
}

extension PoppinViewController{
        fileprivate func prepareTabItem() {
            tabItem.title = "poppin'"
        }
}
