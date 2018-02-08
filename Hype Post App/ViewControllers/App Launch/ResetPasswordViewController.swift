//
//  ResetPasswordViewController.swift
//  Hype Post App
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SVProgressHUD
import Material
import SnapKit

class ResetPasswordViewController: UIViewController {
    
    let constant: CGFloat = 32

    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        emailField.delegate = self
        setupCPB()
        setupLabel()
        setupEmailTF()
        prepareResetButton()
    }
    
    lazy var ResetPasswordLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Reset Password"
        lb.textColor = Color.red.base
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return lb
    }()
    
    lazy var closeButton: FABButton = {
        let button = FABButton(image: Icon.cm.close)
        button.tintColor = Color.red.base
        button.pulseColor = .gray
        button.backgroundColor = .clear
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
    
    func prepareResetButton() {
        let btn = RaisedButton(title: "Reset", titleColor: Color.red.base)
        btn.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        
        self.view.layout(btn).width(100).height(constant).bottom(300).center()
    }
    
    @objc private func resetPassword(){
        SVProgressHUD.show()
        FirebaseAPIClient.manager.resetPassword(withEmail: emailField.text!) { (error) in
            if error != nil {
                SVProgressHUD.dismiss()
                print(error!)
            } else {
                SVProgressHUD.dismiss()
                print("password reset sent")
                let alert = UIAlertController(title: "Sent", message: "Password reset email has been sent", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (complete) in
                    self.dismiss(animated: true, completion: {})
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                self.resignFirstResponder()
            }
        }
        
    }
    
    
    lazy var emailField: ErrorTextField = {
        let tf = ErrorTextField()
        tf.tag = 0
        tf.placeholder = "Email"
        tf.detail = "Error, incorrect email"
        tf.isClearIconButtonEnabled = true
        tf.isPlaceholderUppercasedWhenEditing = true
        tf.placeholderAnimation = .hidden
        tf.autocorrectionType = .no
        return tf
    }()
    
    
    private func setupEmailTF() {
        self.view.addSubview(emailField)
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(ResetPasswordLabel.snp.bottom).offset(50)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            //            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
        }
    }
    
    private func setupLabel() {
        view.addSubview(ResetPasswordLabel)
        ResetPasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            
        }
    }
    
    
    
    @IBAction func sendPassResetButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        FirebaseAPIClient.manager.resetPassword(withEmail: emailField.text!) { (error) in
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


extension ResetPasswordViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        email = textField.text!
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email = textField.text!
        textField.resignFirstResponder()
        return true
    }
}


