//
//  PostViewModel.swift
//  TwitterMimic
//
//  Created by Kyo on 3/17/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

struct PostVM {
    let post: Post
    let user: User
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        
        return formatter.string(from: post.timestamp, to: now) ?? "2m"
    }
    
    var profileImageUrl: URL? {
        return post.user.profileImageUrl
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSMutableAttributedString(string: " \(user.username)",
            attributes: [.font: UIFont.systemFont(ofSize: 14),
                         .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(post: Post) {
        self.post = post
        self.user = post.user
    }
}
