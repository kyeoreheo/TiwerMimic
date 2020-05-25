//
//  PostService.swift
//  TwitterMimic
//
//  Created by Kyo on 3/16/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase

struct PostService {
    static let shared = PostService()
    
    //upload
    func post(contentt: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["content": contentt,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "shared": 0,
                      "uid": uid] as [String: Any]
        
        DB_POST.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchPost(completion: @escaping([Post]) -> Void) {
        var posts = [Post]()
        
        DB_POST.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any],
                  let uid = dictionary ["uid"] as? String
                else { return }
            let postID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let post = Post(user: user, postID: postID, dictionary: dictionary)
                posts.append(post)
                completion(posts)
            }
        }
    }
}
