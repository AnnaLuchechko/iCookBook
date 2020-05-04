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

    @IBAction func categoriesButtonFilled(_ sender: UIButton) {
        let categoriesFilledImagesArray = ["breakfast", "lunch", "dinner", "maincources", "sidedishes", "desserts", "snacks", "salads", "sweets", "soup", "drinks", "sauces"]
        
        let categoriesFilledImage = UIImage(named: categoriesFilledImagesArray[sender.tag])
        imageViews[sender.tag].image = categoriesFilledImage

        print(categoriesFilledImagesArray[sender.tag])


    }
    
    @IBAction func categoriesButtonUnfilled(_ sender: UIButton) {
        let categoriesUnfilledImagesArray = ["breakfast1", "lunch1", "dinner1", "maincources1", "sidedishes1", "desserts1", "snacks1", "salads1", "sweets1", "soup1", "drinks1", "sauces1"]
        
        let unfilledImageCategories = UIImage(named: categoriesUnfilledImagesArray[sender.tag])
        imageViews[sender.tag].image = unfilledImageCategories
        
        print(categoriesUnfilledImagesArray[sender.tag])
    }
    
}
