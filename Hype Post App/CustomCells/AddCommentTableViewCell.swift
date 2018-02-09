//
//  AddCommentTableViewCell.swift
//  Hype Post App
//
//  Created by Caroline Cruz on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material

class AddCommentTableViewCell: UITableViewCell {

    lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .white
        return iv
    }()
    
    lazy var userNameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lb.text = "get userName"
        return lb
    }()
    
    lazy var commentTF: UILabel = {
        let tf = UILabel()
        tf.font = UIFont.systemFont(ofSize: 20, weight: .light)
        tf.numberOfLines = 0
//        tf.allowsEditingTextAttributes = false
        return tf
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "AddCommentCell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
  
    
    
    
    private func commonInit() {
        backgroundColor = UIColor.groupTableViewBackground
        setupViews()
    }
    
    override func layoutSubviews() {
        //    we get the frame of the UI element here
        super.layoutSubviews()
        userImage.layer.cornerRadius = userImage.bounds.width/2.0
        userImage.layer.masksToBounds = true // so it will not bleed outside the bounds
    }
    
    private func setupViews() {
        prepareImageView()
        prepareUserLabel()
        prepareCommentTF()
        
    }
    
}

extension AddCommentTableViewCell {
    
    private func prepareImageView() {
        addSubview(userImage)
        userImage.snp.makeConstraints({ (make) in
            //            make.leading.equalTo(self.snp.leading).offset(16)
            make.top.equalTo(self.snp.top).offset(10)
            make.centerY.equalTo(snp.centerY)
            make.height.width.equalTo(snp.height).multipliedBy(0.5)
            make.leading.equalTo(snp.leading).offset(10)
        })
    }
    
    
    private func prepareUserLabel() {
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(userImage.snp.top)
            make.leading.equalTo(userImage.snp.trailing).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            
        })
    }
    
    private func prepareCommentTF() {
        addSubview(commentTF)
        commentTF.snp.makeConstraints({ (make) in
            make.top.equalTo(userNameLabel.snp.bottom)
            make.leading.equalTo(userImage.snp.trailing).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
        })
        
        
    }
    
}

