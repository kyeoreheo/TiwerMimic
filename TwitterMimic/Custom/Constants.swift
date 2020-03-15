//
//  Constants.swift
//  TwitterMimic
//
//  Created by Kyo on 3/15/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
//Global constants
import Firebase

let DB_REF = Database.database().reference()
let DB_USERS = DB_REF.child("users")

let ST_REF = Storage.storage().reference()
let ST_PROFILE_IMAGE = ST_REF.child("profile_image")
