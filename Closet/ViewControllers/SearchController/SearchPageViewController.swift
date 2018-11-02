//
//  SearchPageViewController.swift
//  Closet
//
//  Created by Levi Linchenko on 30/10/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class SearchPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var subViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "searchPeople") as! PeopleTableViewController,
            UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "searchSize") as! ClothesTableViewController
        ]
    }()
    
    var tableViewIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.index(of: viewController) ?? 0
        tableViewIndex = currentIndex
        
        if currentIndex <= 0 {
            return nil
        }
        return subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.index(of: viewController) ?? 0
        tableViewIndex = currentIndex
        
        
        if currentIndex >= subViewControllers.count - 1 {
            return nil
        }
        return subViewControllers[currentIndex+1]
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let parent = parent as? ContainerViewController else {return}
        
        if previousViewControllers == [subViewControllers[0]] {
            parent.clothesTappedUpdated()
        } else {
            parent.peopleTappedUpdated()
        }
        
        
    }
    
    
    
}
