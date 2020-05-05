//
//  RecipesData.swift
//  iCookBook
//
//  Created by Anna Luchechko on 06.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation

class RecipeData {
    
    func fetchRecipesJsonData(query: String, completionHandler: @escaping (_ data: Data?) -> ()) { //Using escaping closure to get data from Spoonacular API
        let baseURL = "https://api.spoonacular.com/recipes/complexSearch?"
        let queryParam = "query=" + query
        let instructionsRequired = "&instructionsRequired=true"
        let fillIngredients = "&fillIngredients=true"
        let addRecipeInformation = "&addRecipeInformation=true"
        let number = "&number=10"
        let apiKey = "&apiKey=34cca14518a94763b022d99c68d8d6f2"
        
        let finalURL = baseURL + queryParam + instructionsRequired + fillIngredients + addRecipeInformation + number + apiKey   //Create recipe request URL to Spoonacular API
        
        if let url = URL(string: finalURL) {    //Check if URL is created
            URLSession.shared.dataTask(with: url) { data, response, error in    //Using escaping closue dataTask of URLSession to get data, response and error from Spoonacular API
                if error != nil {
                    print("Error fetching data! 😢")
                    completionHandler(nil)  //nil as Data goes to fetchRecipesJsonData -> if we have error from Spoonacular API
                } else {
                    if let data = data {
                        completionHandler(data) //data as Data goes to fetchRecipesJsonData -> if we get data from Spoonacular API and it isn't empty
                    } else {
                        completionHandler(nil)  //error as Data goes to fetchRecipesJsonData -> if we get data from Spoonacular API and it is empty
                    }
                }
            }.resume()  //Run URLSession.shared.dataTask
        }
    }
    
}
