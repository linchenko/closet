//
//  SearchSuperViewController.swift
//  Closet
//
//  Created by Levi Linchenko on 30/10/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class SearchSuperViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(dissmissKeyboard), name: .dissmissSearchBar, object: nil)
        
    }
    
    @objc func dissmissKeyboard(){
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchContainer.isHidden = false
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchContainer.isHidden = true
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
