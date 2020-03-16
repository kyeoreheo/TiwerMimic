//
//  UserService.swift
//  TwitterMimic
//
//  Created by Kyo on 3/15/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        DB_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            print("DEBUG: username \(user.username)")
        }
    }
    
}
