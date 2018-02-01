//
//  DBService+Jobs.swift
//  firebase stuff
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

extension DBService {
    public func addJob(title: String, description: String) {
        let childByAutoId = DBService.manager.getJobs().childByAutoId()
        childByAutoId.setValue(["title"         : title,
                                "description"   : description,
                                "authUserId"    : AuthUserService.getCurrentUser()?.uid,
                                "creator"       : AuthUserService.getCurrentUser()?.displayName,
                                "jobId"         : childByAutoId.key]) {(error, dbRef) in
                                    
                                    if let error = error {
                                        print("addJob error: \(error)")
                                    } else {
                                        print("database reference: \(dbRef)")
                                    }
        }
    }
}
