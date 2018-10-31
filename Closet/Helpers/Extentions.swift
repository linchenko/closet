//
//  Helpers.swift
//  Closet
//
//  Created by Levi Linchenko on 29/10/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func fetchImageWithUrlString(urlString: String, completion: @escaping (_ success: UIImage?)->Void) {
        guard let url = URL(string: urlString) else {return}
        var profileImage: UIImage?
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print ("💩💩 error in file \(#file), function \(#function), \(error),\(error.localizedDescription)💩💩")
                return
            }
            if let data = data {
                profileImage = UIImage(data: data)
            }
            completion(profileImage)
            
        }).resume()
    }
    
}
