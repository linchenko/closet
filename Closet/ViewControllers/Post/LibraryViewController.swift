//
//  PostViewController.swift
//  Closet
//
//  Created by Levi Linchenko on 31/10/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit
import Photos

class LibraryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var mainPhotoOutlet: UIImageView!
    
    
    var photosArray: [Int:UIImage] = [:]
    var selectedPhoto: UIImage?
    var transformValue: CGFloat = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        fetchImage(size: view.frame.width, index: 0) { (image) in
            DispatchQueue.main.async {
                self.mainPhotoOutlet.image = image
                self.selectedPhoto = image
            }
        }
        
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        view.transform = CGAffineTransform(translationX: 0, y: transformValue)
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.view.transform = CGAffineTransform(translationX: 0, y: self.transformValue)
    }
    
    var fetchResult: PHFetchResult<PHAsset> {
        return fetchAssets()
    }
    
    func fetchImage(size: CGFloat, index: Int, completion: @escaping (_ success: UIImage)->Void) {
        let imgManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.deliveryMode = .highQualityFormat
        
        imgManager.requestImage(for: fetchResult.object(at: index), targetSize: CGSize(width: size, height: size), contentMode: .aspectFill, options: requestOptions) { (image, error) in
            guard let image = image else {return}
            completion(image)
            
        }
    }
    
    func fetchAssets() -> PHFetchResult<PHAsset> {
        
     
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if fetchResult.count > 0 {
        } else {
            print("No photos")
            self.photoCollectionView.reloadData()
        }
        return fetchResult
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainPhotoOutlet.image = photosArray[indexPath.row]
        fetchImage(size: view.frame.width, index: indexPath.row) { (image) in
            DispatchQueue.main.async {
                self.mainPhotoOutlet.image = image
                self.selectedPhoto = image
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        let imageView = cell.viewWithTag(1) as! UIImageView
        fetchImage(size: 30, index: indexPath.row) { (image) in
            DispatchQueue.main.async {
                imageView.image = image
                self.photosArray.updateValue(image, forKey: indexPath.row)
            }
        }
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            print("Down")
            
            if scrollView.panGestureRecognizer.translation(in: scrollView).y < -100 {
                UIView.animate(withDuration: 0.5) {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -200)
                }
                transformValue = -200
                return
            }
            
        } else {
            print("Up")
            
            if scrollView.panGestureRecognizer.translation(in: scrollView).y > 100 {
                UIView.animate(withDuration: 0.5) {
                    self.view.transform = .identity
                }
                transformValue = 0
                return
            }
        }
    }
}
