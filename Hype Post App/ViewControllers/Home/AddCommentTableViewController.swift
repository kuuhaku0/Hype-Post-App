//
//  AddCommentTableViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class AddCommentTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AddCommentTableViewCell.self, forCellReuseIdentifier: "AddCommentCell")
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell", for: indexPath) as? AddCommentTableViewCell
            
            return cell!
        }
        
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 100
        }
        return 100
    }

}
