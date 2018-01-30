//
//  Post.swift
//  Hype Post App
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
class Post {
    var header: String = ""
    var body: String = ""
    let upVotes: Int = 0
    let downVotes: Int = 0
    init(header: String, body: String) {
        self.header = header; self.body = body
    }
    
}


