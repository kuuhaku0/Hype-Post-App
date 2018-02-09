//
//  LoginTableViewCell.swift
//  Hype Post App
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Material


protocol LoginTableViewCellDelegate: class{
    func loginHasBeenPressed()
    func resetPasswordHasBeenPressed()
}




class LoginTableViewCell: UITableViewCell{

    override func awakeFromNib() {
    }
    
    
    weak var delegate: LoginTableViewCellDelegate?
    
    let constant: CGFloat = 32
    
    
    
    /// Handle the resign responder button.
    @objc
    internal func handleResignResponderButton(button: UIButton) {
        self.delegate?.loginHasBeenPressed()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    lazy var closeButton: FABButton = {
        let button = FABButton(image: Icon.cm.close)
        button.tintColor = Color.red.base
        button.pulseColor = .gray
        button.backgroundColor = .clear
        //        button.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        return button
    }()
    
    lazy var resetPasswordButton: FlatButton = {
        let button = FlatButton()
        button.tintColor = .white
        button.pulseColor = .gray
        button.titleColor = Color.blue.base
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        button.setTitle("Forgot Password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    @objc private func resetPassword(){
    self.delegate?.resetPasswordHasBeenPressed()
    }
    
    lazy var createAccountLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Sign in to HypePost"
        lb.textColor = Color.red.base
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 24, weight: .medium)
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
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var passwordField: TextField = {
        let tf = TextField()
        tf.tag = 1
        tf.placeholder = "Password"
        tf.clearButtonMode = .whileEditing
        tf.isVisibilityIconButtonEnabled = true
        
        // Setting the visibilityIconButton color.
        tf.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(tf.isSecureTextEntry ? 0.38 : 0.54)
        return tf
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "LoginCell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    
    @objc func dismissKeyboard() {
        self.emailField.endEditing(true)
        self.passwordField.endEditing(true)
    }
    
    
    
    private func commonInit() {
        backgroundColor = .white
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
        setupViews()
    }
    
    private func setupViews() {
        setupLabel()
        setupEmailTF()
        setupPasswordTF()
        setupRPB()
        prepareLoginButton()
        
    }
    
 
    
    
    
    private func setupCB() {
        addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    private func setupEmailTF() {
        addSubview(emailField)
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(createAccountLabel.snp.bottom).offset(50)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            //            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
        }
    }
    
    
    private func setupPasswordTF() {
        addSubview(passwordField)
        passwordField.snp.makeConstraints { (make) in
            make.width.equalTo(emailField.snp.width)
            make.top.equalTo(emailField.snp.bottom).offset(40)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    private func setupRPB() {
        addSubview(resetPasswordButton)
        resetPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.leading.equalTo(passwordField.snp.leading)
        }
    }
    
    private func setupLabel() {
        addSubview(createAccountLabel)
        createAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            
        }
    }
    
    func prepareLoginButton() {
        
        let btn = RaisedButton(title: "Sign In", titleColor: Color.red.base)
        btn.addTarget(self, action: #selector(handleResignResponderButton(button:)), for: .touchUpInside)
        addSubview(btn)
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(resetPasswordButton.snp.bottom).offset(22)
                    make.size.equalTo((CGSize(width: 100, height: constant)))
                    make.centerX.equalTo(self.snp.centerX)
                }
             
//                print("iPhone 5 or 5S or 5C")
            case 1334:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(resetPasswordButton.snp.bottom).offset(22)
                    make.size.equalTo((CGSize(width: 150, height: constant)))
                    make.centerX.equalTo(self.snp.centerX)
                }
//                print("iPhone 6/6S/7/8")
            case 1920,2208:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(resetPasswordButton.snp.bottom).offset(22)
                    make.size.equalTo((CGSize(width: 150, height: constant)))
                    make.centerX.equalTo(self.snp.centerX)
                }
//                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(resetPasswordButton.snp.bottom).offset(22)
                    make.size.equalTo((CGSize(width: 150, height: constant)))
                    make.centerX.equalTo(self.snp.centerX)
                }
//                print("iPhone X")
            default:
                print("unknown")
            }
        }

       
    }
    


}
