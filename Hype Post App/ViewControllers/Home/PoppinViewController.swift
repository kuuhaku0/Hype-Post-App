//
//  PoppinViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class PoppinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabItem()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PoppinViewController{
        fileprivate func prepareTabItem() {
            tabItem.title = "poppin'"
        }
}
