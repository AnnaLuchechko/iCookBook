//
//  CustomTabBarController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 04.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class CustomTabBarController:  UITabBarController, UITabBarControllerDelegate {
    
    var categoriesViewController: CategoriesViewController!
    var discoverViewController: DiscoverViewController!
    var favouritesViewController: FavouritesViewController!


    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        
        categoriesViewController = CategoriesViewController()
        discoverViewController = DiscoverViewController()
        favouritesViewController = FavouritesViewController()

     
        categoriesViewController.tabBarItem.image = UIImage(named: "list")
        categoriesViewController.tabBarItem.selectedImage =
        UIImage(named: "listfilled")
        discoverViewController.tabBarItem.image = UIImage(named: "search")
        discoverViewController.tabBarItem.selectedImage = UIImage(named: "searchfilled")
        favouritesViewController.tabBarItem.image = UIImage(named: "heart")
        favouritesViewController.tabBarItem.selectedImage = UIImage(named: "heartfilled")
        
        viewControllers = [categoriesViewController, discoverViewController, favouritesViewController]
        for tabBarItem in tabBar.items! {
          tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
      if viewController.isKind(of: FavouritesViewController.self) {
         let vc =  FavouritesViewController()
         vc.modalPresentationStyle = .overFullScreen
         self.present(vc, animated: true, completion: nil)
         return false
      }
      return true
    }
    
}
