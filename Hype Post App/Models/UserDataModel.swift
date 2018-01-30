//
//  UserDataModel.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

class User {
    let email: String
    let postCount: Int
    init(email: String, postCount: Int) {
        self.email = email; self.postCount = postCount
    }
}

class UserDataModel {
    private init() {}
    static let manager = UserDataModel()
    static let usersPostHistory: [String:Post] = [:]
    //TO DO implement Firebase
}
