//
//  TabViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let feedVC = FeedViewController.storyboardInstance()
        let popVc = PoppinViewController.storyboardInstance()
        let profileVC = UserActivityViewController.storyboardInstance()
        let tab = tabController(viewControllers: [feedVC, popVc])
        tab.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "icons8-home-page-filled-50"), selectedImage: #imageLiteral(resourceName: "icons8-home-page-filled-50").withRenderingMode(.alwaysOriginal))
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "icons8-male-user-filled-50"), selectedImage: #imageLiteral(resourceName: "icons8-male-user-filled-50").withRenderingMode(.alwaysOriginal))
        tab.tabBar.tintColor = Color.grey.darken1
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.darkGray], for: .selected)
        self.setViewControllers([tab, profileVC], animated: true)
    }
}
