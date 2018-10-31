//
//  ClosetController.swift
//  Closet
//
//  Created by Levi Linchenko on 29/10/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import Foundation


class ClosetController {
    
    static let shared = ClosetController()
    
    private init () {}
    
    var clothes: [Clothes: String] = [:]
    
    var tagCount: Int {
        return getCount()
    }
    
  
    
    
    
    fileprivate func getCount() -> Int {
        var tags: Set<String> = []
        for cloth in clothes {
            tags.update(with: cloth.value)
        }
        return tags.count
    
    }
    
//    let mocData = [Clothes(owner: Friend(uid: "123411234", username: "uasdf", profileImageUrl: "adf"), type: "adf", tag: "Dress", mainImageUrl: "")]
    
}

