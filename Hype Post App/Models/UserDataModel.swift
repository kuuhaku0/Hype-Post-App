//
//  UserDataModel.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

class User {
    let userName: String
    let postCount: Int
    init(userName: String, postCount: Int) {
        self.userName = userName; self.postCount = postCount
    }
}

class UserDataModel {
    private init() {}
    static let manager = UserDataModel()
    static let usersPostHistory: [String:Post] = [:]
    //TO DO implement Firebase
}
