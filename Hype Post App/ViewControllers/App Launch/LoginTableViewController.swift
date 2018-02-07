//
//  LoginTableViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material
import SnapKit
import Firebase
import Kingfisher
import SVProgressHUD


class LoginTableViewController: UITableViewController {
    
    let constant: CGFloat = 32
    var email: String?
    var password: String?
    
    lazy var resetPasswordButton: FlatButton = {
        let button = FlatButton()
        button.tintColor = .white
        button.pulseColor = .gray
        button.titleColor = Color.red.base
        button.backgroundColor = .clear
        button.setTitle("Forgot Password", for: .normal)
        //        button.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        return button
    }()
    
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
    
   
    
    @objc
    internal func loggingIn(button: UIButton) {
        if let email = email, let password = password{
            print(email + " this is 1")
            print(password + " this is two")
            login(withEmail: email, password: password)
        }
    }
    

    func prepareLoginButton() {
        let btn = RaisedButton(title: "Log In", titleColor: Color.red.base)
        btn.addTarget(self, action: #selector(loggingIn(button:)), for: .touchUpInside)
        
        self.view.layout(btn).width(100).height(constant).bottom(300).center()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LoginTableViewCell.self, forCellReuseIdentifier: "LoginCell")
        setupCPB()
        prepareLoginButton()
    
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoginCell", for: indexPath) as! LoginTableViewCell
       cell.selectionStyle = .none
        cell.emailField.delegate = self
        cell.passwordField.delegate = self
        return cell
        
    }
}

extension LoginTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0{
            print(textField.text!)
        email = textField.text!
        }else{
        password = textField.text!
        }
        textField.resignFirstResponder()
        return true
    }
    
    
}


extension LoginTableViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    
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
