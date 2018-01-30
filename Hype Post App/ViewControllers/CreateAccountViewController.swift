//
//  CreateAccountViewController.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        signUp(withEmail: emailTextField.text!, password: passwordTextField.text!, passwordsMatch: true)
    }

}

extension CreateAccountViewController {
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
}
