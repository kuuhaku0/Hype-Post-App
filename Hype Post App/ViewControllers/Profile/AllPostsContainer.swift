//
//  AllPostsContainer.swift
//  Hype Post App
//
//  Created by C4Q on 2/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class AllPostsContainer: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public static func storyboardINstance() -> AllPostsContainer {
        let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
        let allPostsViewController = storyboard.instantiateViewController(withIdentifier: "AllPostsContainer") as! AllPostsContainer
        return allPostsViewController
    }
}
