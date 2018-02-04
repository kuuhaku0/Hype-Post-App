//
//  ProfileViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.register(ProfileInfoCell.self, forCellReuseIdentifier: "ProfileInfoCell")
    }
    
    public static func storyboardInstance() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        return profileViewController
    }
    
    @IBAction func tempLogout(_ sender: UIButton) {
        logout()
    }
    
    func logout() {
        FirebaseAPIClient.manager.logOutCurrentUser()
        show(EntryViewController(), sender: self)
        self.dismiss(animated: true, completion: nil)
    }
}

