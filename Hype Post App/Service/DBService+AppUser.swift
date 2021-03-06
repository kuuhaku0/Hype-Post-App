//
//  DBService+AppUser.swift
//  Hype Post App
//
//  Created by C4Q on 2/5/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DBService {
    public func addAppUser(_ appUser: AppUser) {
        let ref = usersRef.child(appUser.uID)
        ref.setValue(["email": appUser.email,
                      "uID": appUser.uID,
                      "userName": appUser.userName,
                      "firstName": appUser.firstName,
                      "lastName": appUser.lastName as Any,
                      "flags": appUser.flags,
                      "bio": appUser.bio ?? ""])
    }
    
    func getAppUser(with uID: String, completion: @escaping (_ user: AppUser) -> Void) {
        let userRef = usersRef.child(uID)
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            
            guard let email = snapshot.childSnapshot(forPath: "email").value as? String else {return}
            guard let userName = snapshot.childSnapshot(forPath: "userName").value as? String else {return}
            guard let firstName = snapshot.childSnapshot(forPath: "firstName").value as? String else {return}
            guard let lastName = snapshot.childSnapshot(forPath: "lastName").value as? String else {return}
            guard let flags = snapshot.childSnapshot(forPath: "flags").value as? UInt else {return}
            let imageURL = snapshot.childSnapshot(forPath: "imageURL").value as? String
            let bio = snapshot.childSnapshot(forPath: "bio").value as? String
            
            let currentAppUser = AppUser(email: email, userName: userName, uID: uID, firstName: firstName, lastName: lastName, imageURL: imageURL, bio: bio, flags: flags)
            completion(currentAppUser)
        }
    }
    
    public func addImageToAppUser(with url: String, uID: String) {
        addImage(url: url, ref: usersRef, id: uID)
    }
    
    
    public func flagUser(flaggedUID: String, userFlaggedById uID: String) {
        let ref = usersRef.child(flaggedUID)
        
        ref.runTransactionBlock { (mutableData) -> TransactionResult in
            if var userObject = mutableData.value as? [String: Any] {
                var flaggedDict = userObject["flaggedBy"] as? [String:Any] ?? ["no":"data"]
                var flags = userObject["flags"] as? UInt ?? 0
                if flaggedDict[uID] != nil {
                    //self.delegate?.didFlagUser?(self)
                    print("user flagged already")
                    
                } else {
                    flaggedDict[uID] = true
                    flags += 1
                    self.delegate?.didFlagUser?(self)
                }
                userObject["flaggedBy"] = flaggedDict
                userObject["flags"] = flags
                mutableData.value = userObject
                return TransactionResult.success(withValue: mutableData)
            }
            return TransactionResult.success(withValue: mutableData)
        }
    }
    
    
}
