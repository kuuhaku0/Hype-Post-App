//
//  EntryViewTableViewCell.swift
//  Hype Post App
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class EntryViewTableViewCell: UITableViewCell {

    let constant: CGFloat = 32
    
    
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
        prepareSignInButton()
        prepareCreateAccountButton()
        setupImageView()
        setupLabel()
    }
    
    
    lazy var image: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "HypePost")
        return iv
    }()
    
    lazy var welcomeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Sign up to experience the Hype."
        lb.textColor = Color.darkText.primary
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return lb
    }()
    
    
    private func setupLabel() {
        addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            
        }
    }
    
    
    
    private func setupImageView() {
        addSubview(image)
        image.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(150)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.25)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    
    private func prepareSignInButton() {
        let btn = RaisedButton(title: "Sign In", titleColor: Color.red.base)
        btn.addTarget(self, action: #selector(handleSegueToLogInButton(button:)), for: .touchUpInside)
        
        
        self.layout(btn).width(150).height(constant).bottom(300).center().left(40)
    }
    
    /// Handle the resign responder button.
    @objc
    internal func handleSegueToLogInButton(button: UIButton) {
        
    }
    
    private func prepareCreateAccountButton() {
        let btn = RaisedButton(title: "Create Account", titleColor: Color.blue.base)
        btn.addTarget(self, action: #selector(handleSegueToCreateAccountButton(button:)), for: .touchUpInside)
        
        
        self.layout(btn).width(150).height(constant).bottom(300).right(40)
    }
    
    /// Handle the resign responder button.
    @objc
    internal func handleSegueToCreateAccountButton(button: UIButton) {
        
    }

}
