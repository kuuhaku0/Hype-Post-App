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

class CreateAccountTableViewCell: UITableViewCell {

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        firstNameTF.resignFirstResponder()
        lastNameTF.resignFirstResponder()
    }
    
    
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
        lb.placeholder = "First "
        return lb
    }()
    
    lazy var lastNameTF: TextField = {
        let lb = TextField()
        lb.placeholder = "Last "
        return lb
    }()
    
    lazy var userNameTF: TextField = {
        let lb = TextField()
        lb.placeholder = "Username "
        return lb
    }()
    
    lazy var emailField: ErrorTextField = {
        let tf = ErrorTextField()
        tf.placeholder = "Email"
        tf.detail = "Error, incorrect email"
        tf.isClearIconButtonEnabled = true
        tf.isPlaceholderUppercasedWhenEditing = true
        tf.placeholderAnimation = .hidden
        return tf
    }()
    
    lazy var passwordField: TextField = {
        let tf = TextField()
        tf.placeholder = "Password"
        tf.detail = "At least 8 characters"
        tf.clearButtonMode = .whileEditing
        tf.isVisibilityIconButtonEnabled = true
        
        // Setting the visibilityIconButton color.
        tf.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(tf.isSecureTextEntry ? 0.38 : 0.54)
        return tf
    }()
    
    lazy var secondPasswordField: TextField = {
        let tf = TextField()
        tf.placeholder = "Password"
        tf.detail = "Re-enter password"
        tf.clearButtonMode = .whileEditing
        tf.isVisibilityIconButtonEnabled = true
        
        // Setting the visibilityIconButton color.
        tf.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(tf.isSecureTextEntry ? 0.38 : 0.54)
        return tf
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CreateAccountCell")
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupLabel()
        setupEmailTF()
        setupUserName()
        setupFirstNameTF()
        setupLastNameTF()
        setupPasswordTF()
        setupSecondPasswordTF()
    }
    
    
 
    
    private func setupEmailTF() {
        addSubview(emailField)
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(createAccountLabel.snp.bottom).offset(100)
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
    

}
