//
//  TabBarController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 04.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.unselectedItemTintColor = UIColor.black // Text color of unselected items
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont (name: "HelveticaNeue", size: 11)!], for: .normal)
        // UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        // Text color of all items
    }


}
