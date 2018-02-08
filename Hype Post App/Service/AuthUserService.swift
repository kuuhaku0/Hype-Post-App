//
//  AuthUserService.swift
//  Hype Post App
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase

@objc protocol AuthUserServiceDelegate: class {
    
    //Create user delegate protocols
    @objc optional func didFailCreatingUser(_ userService: AuthUserService, error: Error)
    @objc optional func didCreateUser(_ userService: AuthUserService, user: AppUser)
    
    //Sign out delegate protocols
    @objc optional func didFailSigningOut(_ userService: AuthUserService, error: Error)
    @objc optional func didSignOut(_ userService: AuthUserService)
    
    //Sign in de()legate protocols
    @objc optional func didFailSigningIn(_ userService: AuthUserService, error: Error)
    @objc optional func didSignIn(_ userService: AuthUserService, user: AppUser)
    
    //email verification protocols
    @objc optional func didFailEmailVerification(_ authUserService: AuthUserService, user: User, error: String)
     @objc optional func didSendEmailVerification(_ authUserService: AuthUserService, user: User, message: String)
    
}


class AuthUserService: NSObject {
    private override init() {
        super.init()
        self.auth = Auth.auth()
    }
    static let manager = AuthUserService()
    
    
    weak public var delegate: AuthUserServiceDelegate?
    private var auth: Auth!
    public static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func createUser(withEmail email: String, userName: String, password pass: String, firstName: String, lastName: String?) {
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if let error = error {
                self.delegate?.didFailCreatingUser?(self, error: error)
            } else if let user = user {
                user.sendEmailVerification(completion: { (error) in
                    if let error = error {
                        self.delegate?.didFailEmailVerification?(self, user: user, error: error.localizedDescription)
                    } else {
                        self.delegate?.didSendEmailVerification?(self, user: user, message: "A verification email has been sent. Please check your email and verify your account before logging in.")
                    }
                })
                
                let newAppUser = AppUser(email: email, userName: userName, uID: user.uid, firstName:firstName , lastName: lastName, imageURL: nil, bio: nil)
                DBService.manager.addAppUser(newAppUser)
                
                self.delegate?.didCreateUser?(self, user: newAppUser)
                // Update authentication user displayName with their email prefix
                let changeRequest = user.createProfileChangeRequest()
                let stringArray = user.email!.components(separatedBy: "@")
                let username = stringArray[0]
                changeRequest.displayName = username
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("changeRequest error: \(error.localizedDescription)")
                    } else {
                        self.delegate?.didCreateUser?(self, user: newAppUser)
                        print("changeRequest was successful")
                    }
                })
            }
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
            delegate?.didSignOut?(self)
        } catch {
            delegate?.didFailSigningOut?(self, error: error)
        }
    }
    
    public func signIn(withEmail email: String, password pass: String) {
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if let error = error {
                self.delegate?.didFailSigningOut?(self, error: error)
            } else if let user = user {
                
                DBService.manager.getAppUser(with: user.uid, completion: { (AppUser) in
                    self.delegate?.didSignIn?(self, user: AppUser)
                })
            }
        }
    }
}
