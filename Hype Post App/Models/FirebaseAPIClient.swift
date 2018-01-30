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
    
    func login(withEmail email: String, and password: String,
               completion: @escaping (AuthResultCallback)) {
        if Auth.auth().currentUser?.isEmailVerified == true {
            Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        }
        else {
            //TODO: NOTIFY USER TO VERIFY EMAIL
        }
    }
    
    func logOutCurrentUser() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Error Signing out")
        }
    }
    
    func createAccount(withEmail email: String, and password: String,
                       completion: @escaping AuthResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func sendVerificationEmail(completion: @escaping (SendPasswordResetCallback)) {
        Auth.auth().currentUser?.sendEmailVerification(completion: completion)
    }
    
    func resetPassword(withEmail email: String,
                       completion: @escaping (SendPasswordResetCallback)) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
}
