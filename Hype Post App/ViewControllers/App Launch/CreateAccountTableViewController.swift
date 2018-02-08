//
//  CreateAccountTableViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material
import SnapKit
import Firebase

class CreateAccountTableViewController: UITableViewController {
    
    
    var email: String?
    var username: String?
    var firstName: String?
    var lastName: String?
    var password: String?
    var sPassword: String?
    
    
    
    
    
    let constant: CGFloat = 32
    
    func prepareCreateAccountButton() {
        let btn = RaisedButton(title: "Create", titleColor: Color.red.base)
        btn.addTarget(self, action: #selector(handlesSegueintoFeed(button:)), for: .touchUpInside)
        
        
        self.view.layout(btn).width(100).height(constant).bottom(11).center()
    }
    
    /// Handle the segue into feed once account is created button.
    @objc
    internal func handlesSegueintoFeed(button: UIButton) {
        signUp(withEmail: email!,
               password: password!,
               passwordsMatch: checkPasswordsMatch(),
               user: AppUser.init(email: email!, userName: username!, uID:  "", firstName: firstName!, lastName: lastName ?? "", imageURL: nil))
    }
    
    
    lazy var closeButton: FABButton = {
        let button = FABButton(image: Icon.cm.close)
        button.tintColor = .white
        button.pulseColor = .white
        button.backgroundColor = Color.red.base
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    @objc func dismissView(){
        self.dismiss(animated: true) {
        }
    }
    
    private func setupCPB() {
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        prepareCreateAccountButton()
        setupCPB()
        
        tableView.register(CreateAccountTableViewCell.self, forCellReuseIdentifier: "CreateAccountCell")

    }
    //
    //    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
    //        signUp(withEmail: emailTextField.text!,
    //               password: passwordTextField.text!,
    //               passwordsMatch: checkPasswordsMatch(),
    //               user: AppUser.init(email: emailTextField.text!, userName: userName.text!, firstName: FirstNameTF.text!, lastName: LastNameTF.text ?? ""))
    //    }
    //
        func checkPasswordsMatch() -> Bool {
            if password == sPassword {
                return true
            } else {
                return false
            }
        }
    
        func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
                self.dismiss(animated: true, completion: {})
                
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    




    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateAccountCell", for: indexPath) as! CreateAccountTableViewCell
       cell.selectionStyle = .none
        cell.emailField.delegate = self
        cell.userNameTF.delegate = self
        cell.firstNameTF.delegate = self
        cell.lastNameTF.delegate = self
        cell.passwordField.delegate = self
        cell.secondPasswordField.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
}

extension CreateAccountTableViewController: UITextFieldDelegate{
    
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField.tag {
            // email text field
        case 0:
            email = textField.text!
        case 1:
            username = textField.text!
        case 2:
            firstName = textField.text!
        case 3:
            lastName = textField.text!
        case 4:
            password = textField.text!
        case 5:
            sPassword = textField.text!
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        switch textField.tag {
        case 0:
            email = textField.text!
        case 1:
            username = textField.text!
        case 2:
            firstName = textField.text!
        case 3:
            lastName = textField.text!
        case 4:
            password = textField.text!
        case 5:
            sPassword = textField.text!
        default:
            break
        }
    }
    
    
}



extension CreateAccountTableViewController {
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
