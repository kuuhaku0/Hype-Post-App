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
    @IBOutlet weak var passwordConfirmTF: UITextField!
    @IBOutlet weak var FirstNameTF: UITextField!
    @IBOutlet weak var LastNameTF: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        signUp(withEmail: emailTextField.text!,
               password: passwordTextField.text!,
               passwordsMatch: checkPasswordsMatch(),
               user: AppUser.init(email: emailTextField.text!, userName: userName.text!, firstName: FirstNameTF.text!, lastName: LastNameTF.text ?? ""))
    }
    
    func checkPasswordsMatch() -> Bool {
        if passwordTextField.text == passwordConfirmTF.text {
            return true
        } else {
            return false
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension CreateAccountViewController {
    func signUp(withEmail email: String, password pass: String, passwordsMatch bothPassMatch: Bool, user: AppUser) {
        FirebaseAPIClient.manager.createAccount(withEmail: email, and: pass) {(user, error) in
            guard bothPassMatch == true else {
                self.showAlert(title: "Error", message: "Passwords must match")
                return
            }
            if Auth.auth().currentUser != nil {
                print("In currentUser != nil")
                
                //TODO: MAKE DATABASE USER OBJECT
                
                FirebaseAPIClient.manager.sendVerificationEmail {(error) in
                    if error != nil {
                        print(error!)
                    } else {
                        self.showAlert(title: "Success", message: "Verification email sent to \(email)")
                        print("Verification email sent")
                    }
                }
            }
        }
    }
}
