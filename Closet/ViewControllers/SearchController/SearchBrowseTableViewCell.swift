//
//  SearchBrowseTableViewCell.swift
//  Closet
//
//  Created by Levi Linchenko on 01/11/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class SearchBrowseTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var descriptionPicture: UIImageView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myBackgroundView: UIView!
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: myCollectionView).x < 0 {
            print("Left")
        } else {
            print("Right")
        }
        if scrollView.panGestureRecognizer.translation(in: myCollectionView).x < -100 {
            UIView.animate(withDuration: 0.5) {

                self.descriptionPicture.transform = CGAffineTransform(translationX: -80, y: 0)
                self.myCollectionView.transform = CGAffineTransform(translationX: -80, y: 0)
                self.myBackgroundView.transform = CGAffineTransform(translationX: -80, y: 0)
                self.descriptionPicture.alpha = 0.3
            }
            
            
        }
        if scrollView.panGestureRecognizer.translation(in: myCollectionView).x > 130 {
            UIView.animate(withDuration: 0.5) {
                self.descriptionPicture.transform = .identity
                self.myCollectionView.transform = .identity
                self.descriptionPicture.alpha = 1
                self.myBackgroundView.transform = .identity
            }
        }
    }
    
    override func awakeFromNib() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
    
    var images: [UIImage] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchBrowseDisplayCell", for: indexPath)
        guard let imageView = cell.viewWithTag(1) as? UIImageView else {return UICollectionViewCell()}
        imageView.image = images[indexPath.row]
        return cell
    }
    

  

}
