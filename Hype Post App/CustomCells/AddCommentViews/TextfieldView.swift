//
//  TextfieldView.swift
//  Hype Post App
//
//  Created by C4Q on 2/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class TextfieldView: UIView {

    lazy var textfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Write a comment..."
//        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 20
        tf.layer.borderWidth = 0.5
        return tf
    }()
    
    lazy var postButton: UIButton = {
        let but = UIButton ()
        but.setTitle("Post", for: .normal)
        but.setTitleColor(.gray, for: .normal)
        return but
    }()
    
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
        setupTextView()
        setupButton()
    }
    
    
    private func setupButton () {
        addSubview(postButton)
        postButton.snp.makeConstraints { (make) in
            make.leading.equalTo(textfield.snp.trailing).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(2)
            //            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
        }
    }
    
    private func setupTextView() {
        addSubview(textfield)
        textfield.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.75)
            //            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.height.equalTo(40)
        }
    }
    
}
