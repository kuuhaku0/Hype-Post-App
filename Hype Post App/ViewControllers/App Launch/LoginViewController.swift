//
//  ViewController.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase
import Material
import Kingfisher
import SVProgressHUD

class LoginViewController: UIViewController {
    
    //outlets
    
    @IBOutlet weak var emailField: ErrorTextField!
    @IBOutlet weak var passwordField: ErrorTextField!
    
    //button functions
    
    @IBAction func resetPasswordButtonPressed(_ sender: Any) {
        resetPassword(withEmail: emailField.text!)
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        //TODO: CHECK FOR NILS, CHECK FOR SPACE, ERROR MESSAGE FOR INVALID EMAILS OR PASSWORD
        login(withEmail: emailField.text!, password: passwordField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
                self.showAlert(title: "Error", message: "\(error!)")
            } else {
                print("LOGIN SUCCESSFUL")
                SVProgressHUD.dismiss()
                let tabVC = TabViewController()
                self.present(tabVC, animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func resetPassword(withEmail email: String) {
        FirebaseAPIClient.manager.resetPassword(withEmail: email) { (error) in
            if error != nil {
                print(error!)
                self.showAlert(title: "Error", message: "\(error!)")
            } else {
                self.showAlert(title: "Success", message: "Password reset has been sent to \(email)")
            }
        }
    }
}
