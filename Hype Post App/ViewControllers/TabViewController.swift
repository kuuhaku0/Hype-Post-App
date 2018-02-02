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
        let popVc = PoppinViewController()
        let profileVC = ProfileViewController()
        let tab = tabController(viewControllers: [feedVC, popVc])
        tab.tabBarItem = UITabBarItem(title: "f e e d", image: nil, tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "p r o f i l e", image: nil, tag: 1)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], for: .selected)
    
        self.setViewControllers([tab, profileVC], animated: true)
    }
}
