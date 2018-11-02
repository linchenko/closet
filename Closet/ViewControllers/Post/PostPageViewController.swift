//
//  PostPageViewController.swift
//  Closet
//
//  Created by Levi Linchenko on 01/11/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class PostPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
   

    lazy var subViews: [UIViewController] = {
        return [
            UIStoryboard(name: "Post", bundle: nil).instantiateViewController(withIdentifier: "Library") as! LibraryViewController,
            UIStoryboard(name: "Post", bundle: nil).instantiateViewController(withIdentifier: "Camera") as! CameraViewController
        ]
    }()
    
    var myIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViews[0]], direction: .forward, animated: true, completion: nil)
    }
    

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViews.index(of: viewController) ?? 0
        myIndex = currentIndex
        if currentIndex <= 0 {
            return nil
        }
        return subViews[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViews.index(of: viewController) ?? 0
        myIndex = currentIndex
        if currentIndex >= subViews.count - 1 {
            return nil
        }
        return subViews[currentIndex+1]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let parent = parent as? PostSuperViewController else {return}
        if previousViewControllers == [subViews[0]] {
            parent.updateCameraOutlet()
        } else {
            parent.updateLibraryOutlet()
        }
        
        
    }

}
