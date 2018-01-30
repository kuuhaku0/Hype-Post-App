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
    
    
    @IBAction func logInPressed(_ sender: UIButton) {
        //TODO: CHECK FOR NILS, CHECK FOR SPACE, ERROR MESSAGE FOR INVALID EMAILS OR PASSWORD
        
        login(withEmail: emailField.text!, password: passwordField.text!)
        
    }
    
  
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: -FIREBASE METHODS EXTENSION
extension LoginViewController {
    
    func signUp(withEmail email: String, password pass: String, passwordsMatch bothPassMatch: Bool) {
        FirebaseAPIClient.manager.createAccount(withEmail: email, and: pass) {(user, error) in
            guard bothPassMatch == true else {
                //TODO: ALERT USER PASSWORDS DON'T MATCH
                return
            }
            if Auth.auth().currentUser != nil {
                FirebaseAPIClient.manager.sendVerificationEmail {(error) in
                    if error != nil {
                        print(error!)
                    } else {
                        //TODO: NOTIFY USER EMAIL VERIFICATION HAS BEEN SENT
                    }
                }
            }
        }
    }
    
    func login(withEmail email: String, password pass: String) {
        SVProgressHUD.show()
        
        FirebaseAPIClient.manager.login(withEmail: email, and: pass) { (user, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                //TODO: NOTIFY USER OF SIGN IN PROBLEM
                
            } else {
                print("LOGIN SUCCESSFUL")
                SVProgressHUD.dismiss()
                //TODO: SEGUE USER TO MAIN PAGE
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
