//
//  CategoriesViewController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 04.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet var imageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func push(_ sender: UIButton) {
        let imagesArray = ["breakfast", "lunch", "dinner", "maincources", "sidedishes", "desserts", "snacks", "salads", "sweets", "soup", "drinks", "sauces"]
        
        let imagetest = UIImage(named: imagesArray[sender.tag])
        imageViews[sender.tag].image = imagetest
    }
    

}
