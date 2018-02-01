//
//  DBService.swift
//  firebase stuff
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBService {
    
    private init() {
        // Reference to the root of the Firebase database
        dbRef = Database.database().reference()
        
        // Children of root database node
        usersRef = dbRef.child("users")
        jobsRef = dbRef.child("jobs")
        imagesRef = dbRef.child("images")
        categoriesRef = dbRef.child("categories")
    }
    
    static let manager = DBService()
    
    private var dbRef: DatabaseReference!
    private var usersRef: DatabaseReference!
    private var jobsRef: DatabaseReference!
    private var imagesRef: DatabaseReference!
    private var categoriesRef: DatabaseReference!
    
    public func getDB() -> DatabaseReference { return dbRef }
    public func getUsers() -> DatabaseReference { return usersRef }
    public func getJobs() -> DatabaseReference { return jobsRef }
    public func getImages() -> DatabaseReference { return imagesRef }
    public func getCategories() -> DatabaseReference { return categoriesRef }
}
