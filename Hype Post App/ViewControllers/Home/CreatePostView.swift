//
//  CreatePostView.swift
//  Hype Post App
//
//  Created by C4Q on 2/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material

class CreatePostView: UIView {

    
    lazy var closeButton: FABButton = {
        let button = FABButton(image: Icon.cm.close)
        button.tintColor = Color.darkGray
        button.pulseColor = .gray
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    lazy var postButton: RaisedButton = {
        let button = RaisedButton(title: "Post", titleColor: .white)
        button.tintColor = .white
        button.pulseColor = .white
        button.backgroundColor = Color.red.base
        button.layer.cornerRadius = 17
        return button
    }()
    
    lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .gray
        return iv
    }()
    
    lazy var postTitle: UITextField = {
        let tf = UITextField()
        tf.placeholder = "What's happening..."
        tf.font = UIFont.boldSystemFont(ofSize: 15)
        //        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 15
        return tf
    }()
    
    lazy var commentTV: UITextView = {
        let tf = UITextView()
        tf.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        tf.backgroundColor = .white
//        tf.sc = false
        //        tf.layer.cornerRadius = 20
        //        tf.text = "Experience the Hype"
        //        tf.textColor = UIColor.white
        return tf
    }()
    
    
    lazy var postImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .white
        return iv
    }()
    
    lazy var cameraButton: FABButton = {
        let button = FABButton(image: Icon.cm.photoCamera)
        button.tintColor = Color.red.base
        button.pulseColor = .gray
        button.backgroundColor = .clear
        //        button.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        //    we get the frame of the UI element here
        super.layoutSubviews()
        userImage.layer.cornerRadius = userImage.bounds.width/2.0
        userImage.layer.masksToBounds = true // so it will not bleed outside the bounds
        postImage.layer.cornerRadius = 20
        postImage.layer.masksToBounds = true
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupCB()
        setupPostButton()
        prepareImageView()
        preparePostTitle()
        prepareCommentTV()
        preparePostImage()
        prepareCameraButton()

        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.leading.equalTo(userImage.snp.trailing).offset(6)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.top.equalTo(postTitle.snp.bottom).offset(2)
            make.height.equalTo(0.2)
        }
    }
    
    private func setupCB() {
        addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    private func setupPostButton() {
        addSubview(postButton)
        postButton.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }
    
    private func prepareImageView() {
        addSubview(userImage)
        userImage.snp.makeConstraints({ (make) in
            //            make.leading.equalTo(self.snp.leading).offset(16)
            make.top.equalTo(closeButton.snp.bottom).offset(20)
            //            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.height.width.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.075)
            make.leading.equalTo(closeButton.snp.leading)
        })
    }
    
    private func preparePostTitle() {
        addSubview(postTitle)
        postTitle.snp.makeConstraints({ (make) in
            make.top.equalTo(userImage.snp.top)
            make.leading.equalTo(userImage.snp.trailing).offset(10)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.03)
            make.trailing.equalTo(postButton.snp.trailing)
            
        })
    }
    
    private func prepareCommentTV() {
        addSubview(commentTV)
        commentTV.snp.makeConstraints({ (make) in
            make.top.equalTo(postTitle.snp.bottom)
            make.leading.equalTo(userImage.snp.trailing).offset(6)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.1)
            make.trailing.equalTo(postButton.snp.trailing)
            
        })
    }
    
    private func preparePostImage() {
        addSubview(postImage)
        postImage.snp.makeConstraints({ (make) in
            make.top.equalTo(commentTV.snp.bottom).offset(5)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.35)
            make.leading.equalTo(commentTV.snp.leading)
            make.trailing.equalTo(commentTV.snp.trailing)
        })
    }
    
    private func prepareCameraButton() {
        addSubview(cameraButton)
        cameraButton.snp.makeConstraints { (make) in
            make.top.equalTo(postImage.snp.bottom).offset(10)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.height.width.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.075)
        }
    }
    
}

