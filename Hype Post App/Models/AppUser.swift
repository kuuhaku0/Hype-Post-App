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
    var userName: String
    let firstName: String
    let lastName: String?
    init(email: String, userName: String, firstName: String, lastName: String?) {
        self.email = email; self.userName = userName; self.firstName = firstName; self.lastName = lastName
    }
}

