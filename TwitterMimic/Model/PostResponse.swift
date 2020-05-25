//
//  PostResponse.swift
//  TwitterMimic
//
//  Created by Kyo on 3/16/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Foundation

struct Post {
    let postID: String
    let content: String
    let uid: String
    let likes: Int
    let sharedCount: Int
    var timestamp: Date!
    let user: User
    
    init(user: User, postID: String, dictionary: [String: Any]) {
        self.postID = postID
        self.user = user
        
        self.content = dictionary["content"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.sharedCount = dictionary["sharedCount"] as? Int ?? 0
        
        guard let timestamp = dictionary["timestamp"] as? Double else { return }
        self.timestamp = Date(timeIntervalSince1970: timestamp)
    }
    
}
