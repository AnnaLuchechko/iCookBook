//
//  RecipesData.swift
//  iCookBook
//
//  Created by Anna Luchechko on 06.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation

class RecipeData {
    
    private var _favouritesKey = "favourites"
    
    func spoonacoolarApiURL(query: String) -> String { //Get URL for fetching Spoonacular API data
        let baseURL = "https://api.spoonacular.com/recipes/complexSearch?"
        let queryParam = "query=" + query.replacingOccurrences(of: " ", with: "%20")
        let instructionsRequired = "&instructionsRequired=true"
        let fillIngredients = "&fillIngredients=true"
        let addRecipeInformation = "&addRecipeInformation=true"
        let number = "&number=10"
        let apiKey = "&apiKey=5f6b8d3956724e258fb9eb8709656cd3"
        //or 34cca14518a94763b022d99c68d8d6f2
        //or 6b543408e6e84daf9882f6652e201168
        //or 5f6b8d3956724e258fb9eb8709656cd3

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
    
    func getFavouritesRecipes() -> [String]? {
        let favouritesRecipeIds = UserDefaults.standard.stringArray(forKey: _favouritesKey)
        return favouritesRecipeIds
    }
    
    func saveFavouritesRecipes(ids: [String]) {
        UserDefaults.standard.set(ids, forKey: _favouritesKey)
    }
    
    func checkIfIsFavouriteRecipe(id: String) -> Bool {
        let favouritesRecipeIds = getFavouritesRecipes() ?? [String]()
        for recipe in favouritesRecipeIds {
            if (recipe == id) {
                return true
            }
        }
        return false
    }
        
    func addRecipeToFavourites(id: String, recipe: Recipe) {
        var favouritesRecipeIds = getFavouritesRecipes() ?? [String]()
        favouritesRecipeIds.append(id)
        saveFavouritesRecipes(ids: favouritesRecipeIds)
        saveRecipeData(id: id, recipe: recipe)
    }
    
    func removeRecipeFromFavourites(id: String) {
        var favouritesRecipeIds = getFavouritesRecipes() ?? [String]()
        favouritesRecipeIds = favouritesRecipeIds.filter{ $0 != id } //New array filtered by any element of array equals id, if yes - remove that id and save this array
        saveFavouritesRecipes(ids: favouritesRecipeIds)
    }
    
    func saveRecipeData(id: String, recipe: Recipe) {
        if let data = try? JSONEncoder().encode(recipe) { // save data in file json
            UserDefaults.standard.set(data, forKey: id)
        }
    }
    
    func getRecipeData() -> [Recipe] {
        let ids = UserDefaults.standard.array(forKey: _favouritesKey)
        var recipes: [Recipe] = [Recipe]()
        if let recipeIds = ids {
            for id in recipeIds {
                if let data = UserDefaults.standard.value(forKey: id as! String) as? Data,
                let recipe = try? JSONDecoder().decode(Recipe.self, from: data) { // get data from json file
                    recipes.append(recipe)
                }
            }
        }
        return recipes
    }
    
}
