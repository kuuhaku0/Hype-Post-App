//
//  TabViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let feedVC = FeedViewController.storyboardInstance()
        let profileVC = ProfileViewController()
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: nil, tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 1)
        self.setViewControllers([feedVC, profileVC], animated: true)
    }
}
