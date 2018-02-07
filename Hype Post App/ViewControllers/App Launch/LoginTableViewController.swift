//
//  LoginTableViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material
import SnapKit



class LoginTableViewController: UITableViewController {
    

    
    lazy var closeButton: FABButton = {
        let button = FABButton(image: Icon.cm.close)
        button.tintColor = .white
        button.pulseColor = .white
        button.backgroundColor = Color.red.base
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
    
    
//    private func prepareSignInButton() {
//        let btn = RaisedButton(title: "Sign In", titleColor: Color.red.base)
//        btn.addTarget(self, action: #selector(handleSegueToLogInButton(button:)), for: .touchUpInside)
//
//
//        self.view.layout(btn).width(150).height(constant).bottom(300).center().left(40)
//    }
    

    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "LoginCell")
        tableView.delegate = self
        tableView.dataSource = self
        setupCPB()

    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryViewTableViewCell", for: indexPath)
//        let btn = RaisedButton(title: "Sign In", titleColor: Color.red.base)
//        btn.addTarget(self, action: #selector(handleSegueToLogInButton(button:)), for: .touchUpInside)
//        
//        
//        cell.layout(btn).width(150).height(constant).bottom(300).center().left(40)
//        
//        return cell
//        
//    }
}
