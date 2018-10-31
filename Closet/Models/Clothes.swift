//
//  Clothes.swift
//  Closet
//
//  Created by Levi Linchenko on 29/10/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class Clothes: Hashable {
    
    static func == (lhs: Clothes, rhs: Clothes) -> Bool {
        return lhs.mainImageUrl == rhs.mainImageUrl
    }
    
    
    let owner: Friend
    var borrower: Friend?
    let tag: String
    let type: String
    let mainImageUrl: String
    let size: Int
    var images: [UIImage]?
    var posts: [Post]?
    var hashValue: Int {
        return mainImageUrl.hashValue
    }
    
    
    init(owner: Friend, type: String, tag: String, mainImageUrl: String, size: Int) {
        self.owner = owner
        self.type = type
        self.tag = tag
        self.size = size
        self.mainImageUrl = mainImageUrl
    }
    
}

class Post {
    
    let imageUrl: String
    let cloth: Clothes
    var comments: [String]?
    var likes: Int
    
    init(imageUrl: String, cloth: Clothes, likes: Int) {
        self.imageUrl = imageUrl
        self.cloth = cloth
        self.likes = likes
    }
    
    
}
