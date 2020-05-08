//
//  RecipesData.swift
//  iCookBook
//
//  Created by Anna Luchechko on 06.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation

class RecipeData {
    
    func spoonacoolarApiURL(query: String) -> String { //Get URL for fetching Spoonacular API data
        let baseURL = "https://api.spoonacular.com/recipes/complexSearch?"
        let queryParam = "query=" + query
        let instructionsRequired = "&instructionsRequired=true"
        let fillIngredients = "&fillIngredients=true"
        let addRecipeInformation = "&addRecipeInformation=true"
        let number = "&number=10"
        let apiKey = "&apiKey=34cca14518a94763b022d99c68d8d6f2"
        
        let finalURLString = baseURL + queryParam + instructionsRequired + fillIngredients + addRecipeInformation + number + apiKey   //Create recipe request URL to Spoonacular API
        return finalURLString
    }
    
    func fetchDataFromURL(from url: URL, completionHandler: @escaping (_ data: Data?) -> ()) { //Function to fetch data from URL
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error fetching data! 😢 \(error?.localizedDescription ?? "")")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
        dataTask.resume()
    }
    
}
