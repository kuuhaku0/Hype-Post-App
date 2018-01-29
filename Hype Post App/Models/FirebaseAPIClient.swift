//
//  File.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseAPIClient {
    private init() {}
    static let manager = FirebaseAPIClient()
    
    func login(withEmail email: String, and password: String, completion: @escaping (User?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func createAccount(withEmail email: String, and password: String,
                       completion: @escaping AuthResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func logOutCurrentUser() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Error Signing out")
        }
    }
}
