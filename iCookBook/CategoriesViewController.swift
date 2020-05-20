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
        
        let searchController = UISearchController(searchResultsController: nil) //Design settings for SearchBar
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.tintColor = .saturatedGreenColor
        
        let title = UIImage(named: "title.png")  //Title logo "iCookBook"
        let imageView = UIImageView(image:title)
        self.navigationItem.titleView = imageView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let categoriesUnfilledImagesArray = ["breakfast1", "lunch1", "dinner1",
                                                 "maincources1", "sidedishes1", "desserts1",
                                                 "snacks1", "salads1", "sweets1",
                                                 "soup1", "drinks1", "sauces1"]
        
        for index in categoriesUnfilledImagesArray.indices {
            let unfilledImageCategories = UIImage(named: categoriesUnfilledImagesArray[index])
            imageViews[index].image = unfilledImageCategories
            categoryButtonLabels[index].textColor = .unSaturadedGreenColor
        }
        
    }
    
    func searchByRecipe(recipe: String) {
        let discoverViewController = storyboard?.instantiateViewController(identifier: "discoverView") as? DiscoverViewController //Instantiate DiscoverViewController
        discoverViewController?.shownFromCategories = true // change bool variable to let DiscoverViewController know that we came from here
        self.navigationController?.show(discoverViewController!, sender: self)
        discoverViewController?.loadRecipes(recipe: recipe)
    }

    @IBAction func categoriesButtonFilled(_ sender: UIButton) {
        let categoriesFilledImagesArray = ["breakfast", "lunch", "dinner",
                                           "main course", "side dishes", "desserts",
                                           "snacks", "salads", "sweets",
                                           "soup", "drinks", "sauces"]
        
        let buttonLabelColor: [UIColor] = [.myBreakfastOrangeColor, .myLunchYellowColor, .myDinnerGreyPinkColor,
                                           .myMainCourseBrownColor, .mySideDishesBlueColor, .myDessertsBardoColor,
                                           .mySnacksDarkGreyBrownColor, .mySaladsBlueColor, .mySweetsLightBrownColor,
                                           .mySoupGreyColor, .myDrinksPinkColor, .mySaucesBrownColor]
        
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
        categoryButtonLabels[sender.tag].textColor = .unSaturadedGreenColor
    }
    
}
