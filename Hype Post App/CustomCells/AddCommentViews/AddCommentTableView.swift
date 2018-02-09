//
//  AddCommentTableView.swift
//  Hype Post App
//
//  Created by C4Q on 2/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Material

class AddCommentTableView: UIView {

    //    TableView
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(AddCommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.estimatedRowHeight = UITableViewAutomaticDimension
        tv.rowHeight = UITableViewAutomaticDimension
        return tv
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
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

