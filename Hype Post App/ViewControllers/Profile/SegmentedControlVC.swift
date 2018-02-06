//
//  SegmentedControlVC.swift
//  Hype Post App
//
//  Created by C4Q on 2/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import HMSegmentedControl
import SnapKit
import Material

class SegmentedControlVC: tabController {
    
    let tabs = tabController(viewControllers: [UserActivityViewController.storyboardINstance(), AllCommentsContainer.storyboardINstance()])
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupSegmentedControl()
        addChildViewController(tabs)
    }

    public static func storyboardINstance() -> SegmentedControlVC {
        let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
        let scVC = storyboard.instantiateViewController(withIdentifier: "SegmentedControlVC") as! SegmentedControlVC
        return scVC
    }
}
