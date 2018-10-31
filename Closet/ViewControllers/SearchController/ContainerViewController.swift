//
//  ContainerViewController.swift
//  Closet
//
//  Created by Levi Linchenko on 30/10/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var peopleButtonOutlet: UIButton!
    @IBOutlet weak var clothesButtonOutlet: UIButton!
    
    
    var child: UIViewController?

        
    override func viewDidLoad() {
        super.viewDidLoad()
        child = children.first
    }
    
    func peopleTappedUpdated(){
        clothesButtonOutlet.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16.0)
        peopleButtonOutlet.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
    }
    
    func clothesTappedUpdated(){
        clothesButtonOutlet.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        peopleButtonOutlet.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
    }
    
    
    @IBAction func peopleTapped(_ sender: Any) {
        guard let child = child as? SearchPageViewController else {return}
        peopleTappedUpdated()
        child.setViewControllers([child.subViewControllers[0]], direction: .reverse, animated: true, completion: nil)
    }
    
    @IBAction func clothesTapped(_ sender: Any) {
        guard let child = child as? SearchPageViewController else {return}
        clothesTappedUpdated()
        child.setViewControllers([child.subViewControllers[1]], direction: .forward, animated: true, completion: nil)
    }
    
    

}
