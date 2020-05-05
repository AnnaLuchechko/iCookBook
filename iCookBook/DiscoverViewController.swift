//
//  DiscoverViewController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 04.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    let recipeData = RecipeData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recipeData.fetchRecipesJsonData(query: "lasagna") { (data) in
            if let response = data {
                DispatchQueue.main.async {
                    let recipes = try? JSONDecoder().decode(Recipes.self, from: response)
                    print (recipes?.results[0].title ?? "no result")
                }
            }
        }
    }
}
