//
//  AppUser.swift
//  Hype Post App
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseAuth

class AppUser: NSObject {
    let email: String
    let uID: String
    var userName: String
    init(email: String, uID: String, userName: String) {
        self.email = email; self.uID = uID; self.userName = userName
    }
}

