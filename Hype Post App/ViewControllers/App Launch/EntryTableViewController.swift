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

    let constant: CGFloat = 32

    private func prepareSignInButton() {
        let btn = RaisedButton(title: "Sign In", titleColor: Color.red.base)
        btn.addTarget(self, action: #selector(handleSegueToLogInButton(button:)), for: .touchUpInside)
        
        
        self.view.layout(btn).width(150).height(constant).bottom(300).left(40).center() }
    
    @objc
    internal func handleSegueToLogInButton(button: UIButton) {
        
    }
    
    private func prepareCreateAccountButton() {
        let btn = RaisedButton(title: "Create Account", titleColor: Color.blue.base)
        btn.addTarget(self, action: #selector(handleSegueToCreateAccountButton(button:)), for: .touchUpInside)
        
        self.view.layout(btn).width(150).height(constant).bottom(300).right(40).center(offsetX: 100, offsetY: 0)
    }
    
    /// Handle the resign responder button.
    @objc
    internal func handleSegueToCreateAccountButton(button: UIButton) {
        
        let vc = CreateAccountTableViewController()
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        tableView.register(EntryViewTableViewCell.self, forCellReuseIdentifier: "EntryCell")
        tableView.delegate = self
        tableView.dataSource = self
        prepareSignInButton()
        prepareCreateAccountButton()
        tableView.allowsSelection = false
    }
    
    public static func storyboardInstance() -> EntryTableViewController {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "EntryTableViewController") as! EntryTableViewController
        return VC
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
