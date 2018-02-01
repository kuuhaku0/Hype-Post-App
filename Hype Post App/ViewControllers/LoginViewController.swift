//
//  ViewController.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import SVProgressHUD

class LoginViewController: UIViewController {
    
    //outlets
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //button functions
    
    @IBAction func resetPasswordButtonPressed(_ sender: Any) {
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        //TODO: CHECK FOR NILS, CHECK FOR SPACE, ERROR MESSAGE FOR INVALID EMAILS OR PASSWORD
        login(withEmail: emailField.text!, password: passwordField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: -FIREBASE METHODS EXTENSION
extension LoginViewController {
    
    func login(withEmail email: String, password pass: String) {
        SVProgressHUD.show()
        FirebaseAPIClient.manager.login(withEmail: email, and: pass) { (user, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                print("Error Signing in")
                //TODO: NOTIFY USER OF SIGN IN PROBLEM
            } else {
                print("LOGIN SUCCESSFUL")
                SVProgressHUD.dismiss()
                //TODO: SEGUE USER TO MAIN PAGE
                let feedVC = FeedViewController()
                let navigationController = UINavigationController(rootViewController: feedVC)
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }
    
    func resetPassword(withEmail email: String) {
        FirebaseAPIClient.manager.resetPassword(withEmail: email) { (error) in
            if error != nil {
                print(error!)
                //TODO: NOTIFY USER RESET PASSWORD FAILED
            } else {
                //TODO: NOTIFY USER PASSWORD RESET HAS BEEN SET TO EMAIL
            }
        }
    }
}
