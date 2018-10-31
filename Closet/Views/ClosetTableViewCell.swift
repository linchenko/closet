//
//  ClosetTableViewCell.swift
//  Closet
//
//  Created by Levi Linchenko on 29/10/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class ClosetTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var itemTag: String?
    
    var clothes: [Clothes]{
        let clothesDictionary = ClosetController.shared.clothes.filter{$0.value == itemTag}
        return clothesDictionary.compactMap{$0.key}
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clothingCell", for: indexPath) as? ClothingCollectionViewCell
        let cloth = clothes[indexPath.row]
        fetchImageWithUrlString(urlString: cloth.mainImageUrl) { (image) in
            DispatchQueue.main.async {
                cell?.imageOutlet.image = image
            }
        }
        
        return cell ?? UICollectionViewCell()
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
