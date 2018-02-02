//
//  ResetPasswordViewController.swift
//  Hype Post App
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SVProgressHUD

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendPassResetButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        FirebaseAPIClient.manager.resetPassword(withEmail: emailTextField.text!) { (error) in
            if error != nil {
                SVProgressHUD.dismiss()
                print(error!)
            } else {
                SVProgressHUD.dismiss()
                print("password reset sent")
                let alert = UIAlertController(title: "Sent", message: "Password reset email has been sent", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (complete) in
                    //TODO: SEGUE BACK TO LOGIN!
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                self.resignFirstResponder()
            }
        }
    }
}


