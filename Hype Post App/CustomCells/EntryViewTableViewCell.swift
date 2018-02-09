//
//  EntryViewTableViewCell.swift
//  Hype Post App
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Material

protocol EntryViewTableViewCellDelegate : class {
    func EntryViewTableViewCellSignInPressed()
    func EntryViewTableViewCellCreateAccountPressed()
}

class EntryViewTableViewCell: UITableViewCell {

    weak var delegate: EntryViewTableViewCellDelegate?

    let constant: CGFloat = 32
    
    @objc
    internal func handleSegueToLogInButton(button: UIButton) {
        let vc = LoginTableViewController()
        self.delegate?.EntryViewTableViewCellSignInPressed()
    }
    
   
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "EntryCell")
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
        setupImageView()
        prepareCreateAccountButton()
        prepareSignInButton()
//        setupLabel()
    }
    
    
    lazy var imageLogo: UIImageView = {
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
            make.top.equalTo(imageLogo.snp.bottom)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            
        }
    }
    
    
    
    private func setupImageView() {
        addSubview(imageLogo)
        imageLogo.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(150)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.25)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    private func prepareSignInButton() {
        let btn = RaisedButton(title: "Sign In", titleColor: Color.red.base)
        btn.addTarget(self, action: #selector(handleSegueToLogInButton(button:)), for: .touchUpInside)
        addSubview(btn)
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(imageLogo.snp.bottom).offset(11)
                    make.size.equalTo(CGSize(width: 135, height: constant))
                    make.left.equalTo(imageLogo.snp.left).offset(3)
                    
                }
                print("iPhone 5 or 5S or 5C")
            case 1334:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(imageLogo.snp.bottom).offset(11)
                        make.size.equalTo(CGSize(width: 150, height: constant))
                    make.left.equalTo(imageLogo.snp.left).offset(10)
                    
                }
                print("iPhone 6/6S/7/8")
            case 1920,2208:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(imageLogo.snp.bottom).offset(11)
                    make.size.equalTo(CGSize(width: 150, height: constant))
                    make.left.equalTo(imageLogo.snp.left).offset(10)
                    
                }
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(imageLogo.snp.bottom).offset(11)
                    make.size.equalTo(CGSize(width: 150, height: constant))
                    make.left.equalTo(imageLogo.snp.left).offset(10)
                }
                print("iPhone X")
            default:
                print("unknown")
            }
        }
    }

//    
//    private func prepareSignInButton() {
//        let btn = RaisedButton(title: "Sign In", titleColor: Color.red.base)
//        btn.addTarget(self, action: #selector(handleSegueToLogInButton(button:)), for: .touchUpInside)
//        
//        
//        self.layout(btn).width(150).height(constant).bottom(300).center().left(40)
//    }
//    
//    /// Handle the resign responder button.
//    @objc
//    internal func handleSegueToLogInButton(button: UIButton) {
//        
//    }
//    
    private func prepareCreateAccountButton() {
        let btn = RaisedButton(title: "Create Account", titleColor: Color.blue.base)
        btn.addTarget(self, action: #selector(handleSegueToCreateAccountButton(button:)), for: .touchUpInside)
        addSubview(btn)
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(imageLogo.snp.bottom).offset(11)
                    make.size.equalTo(CGSize(width: 135, height: constant))
                    make.right.equalTo(imageLogo.snp.right).offset(-3)
                    
                }
                print("iPhone 5 or 5S or 5C")
            case 1334:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(imageLogo.snp.bottom).offset(11)
                    make.size.equalTo(CGSize(width: 150, height: constant))
                    make.right.equalTo(imageLogo.snp.right).offset(-10)
                    
                }
                print("iPhone 6/6S/7/8")
            case 1920,2208:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(imageLogo.snp.bottom).offset(11)
                    make.size.equalTo(CGSize(width: 150, height: constant))
                    make.right.equalTo(imageLogo.snp.right).offset(-10)
                }
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(imageLogo.snp.bottom).offset(11)
                    make.size.equalTo(CGSize(width: 150, height: constant))
                    make.right.equalTo(imageLogo.snp.right).offset(-10)
                    
                }
                print("iPhone X")
            default:
                print("unknown")
            }
        }
       
    }
    
    /// Handle the resign responder button.
    @objc
    internal func handleSegueToCreateAccountButton(button: UIButton) {
        self.delegate?.EntryViewTableViewCellCreateAccountPressed()
    }

}
