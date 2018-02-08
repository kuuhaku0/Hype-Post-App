//
//  SettingsViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func logout(_ sender: UIButton) {
        logout()
        present(EntryTableViewController.storyboardInstance(), animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        resignFirstResponder()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tableView.bounces = false
        view.addGestureRecognizer(tap)
        tableView.dataSource = self
        tableView.delegate = self
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard() {
        resignFirstResponder()
    }
    
    fileprivate func logout() {
        FirebaseAPIClient.manager.logOutCurrentUser()
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
            self.dismiss(animated: false, completion: {
            })
        let entryVC = EntryTableViewController.storyboardInstance()
        let navController =  UINavigationController(rootViewController: entryVC)
        present(navController, animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1050
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath)
            return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

