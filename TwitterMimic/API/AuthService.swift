//
//  AuthService.swift
//  TwitterMimic
//
//  Created by Kyo on 3/15/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import Firebase

struct AuthProperties {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(email: String, password: String) {
        print("email: \(email), pw: \(password)")
    }
    
    func registerUser(user: AuthProperties, completion: @escaping(Error?, DatabaseReference) -> Void ) {
        guard let imageData = user.profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let storageRef =  ST_PROFILE_IMAGE.child(filename)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
                    if let error = error {
                        print("Error is \(error.localizedDescription)")
                        return
                    }
                   
                    guard let uid = result?.user.uid else { return }
                       
                    let values = ["email": user.email,
                                  "username": user.username,
                                  "fullname": user.fullname,
                                  "profileImageUrl": profileImageUrl]
                       
                    DB_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
               }
           }
        }
    }
    
}
