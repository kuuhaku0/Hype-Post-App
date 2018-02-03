//
//  DBService+AppUser.swift
//  Hype Post App
//
//  Created by C4Q on 2/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
extension DBService {
    public func addAppUser(_ appUser: AppUser) {
        let ref = usersRef.child(appUser.uID)
        ref.setValue(["email": appUser.email,
                      "uID": appUser.uID,
                      "userName": appUser.userName,
                      "firstName": appUser.firstName,
                      "lastName": appUser.lastName ])
    }
    
    func getAppUser(with uID: String, completion: @escaping (_ user: AppUser) -> Void) {
        let userRef = usersRef.child(uID)
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let email = snapshot.childSnapshot(forPath: "email").value as? String else {return}
            guard let userName = snapshot.childSnapshot(forPath: "userName").value as? String else {return}
            guard let firstName = snapshot.childSnapshot(forPath: "firstName").value as? String else {return}
            guard let lastName = snapshot.childSnapshot(forPath: "lastName").value as? String else {return}
            let imageURL = snapshot.childSnapshot(forPath: "imageURL").value as? String
            
            let currentAppUser = AppUser(email: email, userName: userName, uID: uID, firstName: firstName, lastName: lastName, imageURL: imageURL)
            completion(currentAppUser)
        }
    }
}
