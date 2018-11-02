//
//  PostSuperViewController.swift
//  Closet
//
//  Created by Levi Linchenko on 01/11/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class PostSuperViewController: UIViewController {

    @IBOutlet weak var libraryOutlet: UIBarButtonItem!
    @IBOutlet weak var cameraOutlet: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateLibraryOutlet(){
        libraryOutlet.style = .done
        cameraOutlet.style = .plain
    }
    
    func updateCameraOutlet(){
        libraryOutlet.style = .plain
        cameraOutlet.style = .done
        
    }
    
    @IBAction func libraryTapped(_ sender: Any) {
        guard let child = children.first as? PostPageViewController else {return}
        child.setViewControllers([child.subViews[0]], direction: .reverse, animated: true, completion: nil)
        updateLibraryOutlet()
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        guard let child = children.first as? PostPageViewController else {return}
        child.setViewControllers([child.subViews[1]], direction: .forward, animated: true, completion: nil)
        updateCameraOutlet()
    }
    
    
}
