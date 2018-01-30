//
//  CreateAccountView.swift
//  Hype Post App
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import SnapKit
import UIKit

class CreateAccountView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
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
        
    }
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        return tf
    }()
    
    lazy var userNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "username"
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        return tf
    }()

    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.addSubview()
        return sv
    }()
}
