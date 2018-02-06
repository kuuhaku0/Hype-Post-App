//
//  AllCommentsContainer.swift
//  Hype Post App
//
//  Created by C4Q on 2/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class AllCommentsContainer: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public static func storyboardINstance() -> AllCommentsContainer {
        let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
        let allCommentsVC = storyboard.instantiateViewController(withIdentifier: "AllCommentsContainer") as! AllCommentsContainer
        return allCommentsVC
    }
}
