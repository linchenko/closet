//
//  User.swift
//  Closet
//
//  Created by Levi Linchenko on 29/10/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit
import CoreLocation


class User {
    
    let uid: String
    let username: String
    let email: String
    let profileImageUrl: String
    var profileImage: UIImage?
    let topSize: Int
    let bottomSize: Int
    let shoeSize: Int
    let closet: [Clothes]
    let followers: [Friend]
    let following: [Friend]
    let blocked: [Friend]
    let location: CLLocationCoordinate2D
    
    init(uid: String, username: String, email: String, profileImageUrl: String, topSize: Int, bottomSize: Int, shoeSize: Int, closet: [Clothes], follers: [Friend], following: [Friend], followers: [Friend], blocked: [Friend], location: CLLocationCoordinate2D) {
        self.uid = uid
        self.username = username
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.topSize = topSize
        self.bottomSize = bottomSize
        self.shoeSize = shoeSize
        self.closet = closet
        self.followers = followers
        self.following = following
        self.blocked = blocked
        self.location = location
    }
    
}



class Friend {
    let uid: String
    let username: String
    let profileImageUrl: String
    let topSize: Int
    let bottomSize: Int
    let shoeSize: Int
    
    init(uid: String, username: String, profileImageUrl: String, topSize: Int, bottomSize: Int, shoeSize: Int) {
        self.uid = uid
        self.username = username
        self.profileImageUrl = profileImageUrl
        self.topSize = topSize
        self.bottomSize = bottomSize
        self.shoeSize = shoeSize
    }
    
}


