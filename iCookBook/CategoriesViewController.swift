//
//  CategoriesViewController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 04.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet var categoryButtonLabels: [UILabel]!
    @IBOutlet var imageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController?.searchBar.tintColor = .white
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.tintColor = .white

    }
    
    func searchByRecipe(recipe: String) {
        let discoverViewController = storyboard?.instantiateViewController(identifier: "discoverView") as? DiscoverViewController
        self.navigationController?.pushViewController(discoverViewController!, animated: true)
        discoverViewController?.loadRecipes(recipe: recipe)
    }

    @IBAction func categoriesButtonFilled(_ sender: UIButton) {
        let categoriesFilledImagesArray = ["breakfast", "lunch", "dinner",
                                           "maincources", "sidedishes", "desserts",
                                           "snacks", "salads", "sweets",
                                           "soup", "drinks", "sauces"]
        let buttonLabelColor = [UIColor(red: 0.76, green: 0.49, blue: 0.28, alpha: 1.00),
                                UIColor(red: 0.85, green: 0.75, blue: 0.09, alpha: 1.00),
                                UIColor(red: 0.52, green: 0.33, blue: 0.36, alpha: 1.00),
                                UIColor(red: 0.55, green: 0.38, blue: 0.24, alpha: 1.00),
                                UIColor(red: 0.25, green: 0.32, blue: 0.53, alpha: 1.00),
                                UIColor(red: 0.44, green: 0.17, blue: 0.22, alpha: 1.00),
                                UIColor(red: 0.31, green: 0.23, blue: 0.24, alpha: 1.00),
                                UIColor(red: 0.25, green: 0.32, blue: 0.53, alpha: 1.00),
                                UIColor(red: 0.51, green: 0.33, blue: 0.20, alpha: 1.00),
                                UIColor(red: 0.48, green: 0.53, blue: 0.53, alpha: 1.00),
                                UIColor(red: 0.64, green: 0.38, blue: 0.49, alpha: 1.00),
                                UIColor(red: 0.41, green: 0.27, blue: 0.17, alpha: 1.00)]
        
        let categoriesFilledImage = UIImage(named: categoriesFilledImagesArray[sender.tag])
        imageViews[sender.tag].image = categoriesFilledImage
        
        categoryButtonLabels[sender.tag].textColor = buttonLabelColor[sender.tag]
        
        searchByRecipe(recipe: categoriesFilledImagesArray[sender.tag])
    }
    
    @IBAction func categoriesButtonUnfilled(_ sender: UIButton) {
        let categoriesUnfilledImagesArray = ["breakfast1", "lunch1", "dinner1",
                                             "maincources1", "sidedishes1", "desserts1",
                                             "snacks1", "salads1", "sweets1",
                                             "soup1", "drinks1", "sauces1"]
        
        let unfilledImageCategories = UIImage(named: categoriesUnfilledImagesArray[sender.tag])
        imageViews[sender.tag].image = unfilledImageCategories
    
        categoryButtonLabels[sender.tag].textColor = UIColor(red: 0.21, green: 0.58, blue: 0.49, alpha: 1.00)
    }
    
}
