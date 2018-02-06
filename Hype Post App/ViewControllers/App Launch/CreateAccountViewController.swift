//
//  CreateAccountViewController.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
import Firebase
import Material
import SnapKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var tbBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
  
    var createCell = CreateAccountTableViewCell()
    
    
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
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupCPB()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
    }
//
//    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
//        signUp(withEmail: emailTextField.text!,
//               password: passwordTextField.text!,
//               passwordsMatch: checkPasswordsMatch(),
//               user: AppUser.init(email: emailTextField.text!, userName: userName.text!, firstName: FirstNameTF.text!, lastName: LastNameTF.text ?? ""))
//    }
//
//    func checkPasswordsMatch() -> Bool {
//        if passwordTextField.text == passwordConfirmTF.text {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    func showAlert(title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
//}
//
//extension CreateAccountViewController {
//    func signUp(withEmail email: String, password pass: String, passwordsMatch bothPassMatch: Bool, user: AppUser) {
//        FirebaseAPIClient.manager.createAccount(withEmail: email, and: pass) {(user, error) in
//            guard bothPassMatch == true else {
//                self.showAlert(title: "Error", message: "Passwords must match")
//                return
//            }
//            if Auth.auth().currentUser != nil {
//                print("In currentUser != nil")
//
//                //TODO: MAKE DATABASE USER OBJECT
//
//                FirebaseAPIClient.manager.sendVerificationEmail {(error) in
//                    if error != nil {
//                        print(error!)
//                    } else {
//                        self.showAlert(title: "Success", message: "Verification email sent to \(email)")
//                        print("Verification email sent")
//                    }
//                }
//            }
//        }
//    }
}

extension CreateAccountViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateAccountCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
