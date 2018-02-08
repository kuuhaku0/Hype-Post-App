//
//  EntryTableViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material
import SnapKit

class EntryTableViewController: UITableViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        tableView.register(EntryViewTableViewCell.self, forCellReuseIdentifier: "EntryCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
    
    public static func storyboardInstance() -> EntryTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "EntryTableViewController") as! EntryTableViewController
        return VC
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryViewTableViewCell
        cell.delegate = self
        return cell
    }
}

extension EntryTableViewController: EntryViewTableViewCellDelegate{
    func EntryViewTableViewCellCreateAccountPressed() {
        let vc = CreateAccountTableViewController()
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    func EntryViewTableViewCellSignInPressed() {
        let vc = LoginTableViewController()
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
}
