//
//  FavouritesViewController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 04.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    let recipesData = RecipeData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.tintColor = UIColor(red: 0.92, green: 0.93, blue: 0.93, alpha: 1.00)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let favouritesRecipes = recipesData.getRecipeData()
        for recipe in favouritesRecipes {
            print(recipe.title)
        }
    }
    
    

}
