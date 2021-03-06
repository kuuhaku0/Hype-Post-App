//
//  CreateAccountTableViewCell.swift
//  Hype Post App
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material
import SnapKit
import Firebase

protocol CreateAccountTableViewCellDelegate: class{
    func createAccountButtonPressed()
}



class CreateAccountTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        firstNameTF.resignFirstResponder()
        lastNameTF.resignFirstResponder()
    }
    
    weak var delegate: CreateAccountTableViewCellDelegate?
    
    
    lazy var createAccountLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Create Account"
        lb.textColor = Color.red.base
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return lb
    }()
    
    lazy var firstNameTF: TextField = {
        let lb = TextField()
        lb.tag = 2
        lb.placeholder = "First "
        return lb
    }()
    
    lazy var lastNameTF: TextField = {
        let lb = TextField()
        lb.tag = 3
        lb.placeholder = "Last "
        return lb
    }()
    
    lazy var userNameTF: TextField = {
        let lb = TextField()
        lb.tag = 1
        lb.placeholder = "Username "
        return lb
    }()
    
    lazy var emailField: ErrorTextField = {
        let tf = ErrorTextField()
        tf.tag = 0
        tf.placeholder = "Email"
        tf.detail = "Error, incorrect email"
        tf.isClearIconButtonEnabled = true
        tf.isPlaceholderUppercasedWhenEditing = true
        tf.placeholderAnimation = .hidden
        return tf
    }()
    
    lazy var passwordField: TextField = {
        let tf = TextField()
        tf.tag = 4
        tf.placeholder = "Password"
        tf.detail = "At least 6 characters"
        tf.clearButtonMode = .whileEditing
        tf.isVisibilityIconButtonEnabled = true
        
        // Setting the visibilityIconButton color.
        tf.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(tf.isSecureTextEntry ? 0.38 : 0.54)
        return tf
    }()
    
    lazy var secondPasswordField: TextField = {
        let tf = TextField()
        tf.tag = 5
        tf.placeholder = "Password"
        tf.detail = "Re-enter password"
        tf.clearButtonMode = .whileEditing
        tf.isVisibilityIconButtonEnabled = true
        
        // Setting the visibilityIconButton color.
        tf.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(tf.isSecureTextEntry ? 0.38 : 0.54)
        return tf
    }()
    
    lazy var createButton: RaisedButton = {
        let btn = RaisedButton(title: "Create", titleColor: Color.red.base)
        btn.addTarget(self, action: #selector(segueToLoginAfterCreate), for: .touchUpInside)
        return btn
    }()
    
    @objc func segueToLoginAfterCreate(){
        self.delegate?.createAccountButtonPressed()
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CreateAccountCell")
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
  
    @objc func dismissKeyboard() {
       self.emailField.endEditing(true)
        self.userNameTF.endEditing(true)
        self.firstNameTF.endEditing(true)
        self.lastNameTF.endEditing(true)
        self.passwordField.endEditing(true)
        self.secondPasswordField.endEditing(true)

    }
    
    
    private func commonInit() {
        backgroundColor = .white
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
        setupViews()
        self.isSelected = false
    }
    
    private func setupViews() {
        setupLabel()
        setupEmailTF()
        setupUserName()
        setupFirstNameTF()
        setupLastNameTF()
        setupPasswordTF()
        setupSecondPasswordTF()
        prepareCreateAccountButton()
        }
    
    
 
    
    private func setupEmailTF() {
        addSubview(emailField)
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(createAccountLabel.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            //            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
        }
    }
    
    private func setupUserName() {
        addSubview(userNameTF)
        userNameTF.snp.makeConstraints { (make) in
            make.top.equalTo(emailField.snp.bottom).offset(40)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(emailField.snp.width)
        }
    }
    
    private func setupFirstNameTF() {
        addSubview(firstNameTF)
        firstNameTF.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTF.snp.bottom).offset(40)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(userNameTF.snp.width).multipliedBy(0.44)
            make.leading.equalTo(userNameTF.snp.leading)
        }
    }
    
    private func setupLastNameTF() {
        addSubview(lastNameTF)
        lastNameTF.snp.makeConstraints { (make) in
            make.leading.equalTo(firstNameTF.snp.trailing).offset(2)
            make.top.equalTo(userNameTF.snp.bottom).offset(40)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(userNameTF.snp.width).multipliedBy(0.44)
            make.trailing.equalTo(userNameTF.snp.trailing)
        }
    }
    
    private func setupPasswordTF() {
        addSubview(passwordField)
        passwordField.snp.makeConstraints { (make) in
            make.width.equalTo(emailField.snp.width)
            make.top.equalTo(firstNameTF.snp.bottom).offset(40)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    private func setupSecondPasswordTF() {
        addSubview(secondPasswordField)
        secondPasswordField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordField.snp.bottom).offset(50)
            make.width.equalTo(emailField.snp.width)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    private func setupLabel() {
        addSubview(createAccountLabel)
        createAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            
        }
    }
    
    private func prepareCreateAccountButton() {
        addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.top.equalTo(secondPasswordField).offset(60)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.25)
        }
    }

}
