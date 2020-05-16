//
//  RecipeViewController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 11.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    
    @IBOutlet weak var favouriteButtonReference: UIButton!
    
    @IBAction func favouriteButton(_ sender: UIButton) {
        if (checkIfIsFavouriteRecipe(id: String(recipes?.id ?? 0))) {
            removeRecipeFromFavourites(id: String(recipes?.id ?? 0))
            favouriteButtonReference.setImage(UIImage(named: "heart"), for: .normal)
        } else {
            addRecipeToFavourites(id: String(recipes?.id ?? 0))
            favouriteButtonReference.setImage(UIImage(named: "heartfilled"), for: .normal)
        }
    }
    
    let favouritesKey = "favourites"
    

    @IBOutlet weak var recipeScrollView: UIScrollView!
    var imageURL: String = ""
    let recipesData = RecipeData()
    var recipes: Recipe?
    
    @IBOutlet weak var recipeNavigationItem: UINavigationItem!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if (checkIfIsFavouriteRecipe(id: String(recipes?.id ?? 0))) {
            favouriteButtonReference.setImage(UIImage(named: "heartfilled"), for: .normal)
        } else {
            favouriteButtonReference.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeNavigationItem.title = recipes?.title.uppercased()
        navigationController?.navigationBar.topItem?.title = " "

        recipeScrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        
        let mainImage = UIImageView()
        mainImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        mainImage.contentMode = .scaleAspectFill
        recipeScrollView.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.93, alpha: 1.00)
        recipeScrollView.addSubview(mainImage)

        let image = URL(string: imageURL)
        self.recipesData.fetchDataFromURL(from: (image)!) { (imageData) in
            if let data = imageData {
                DispatchQueue.main.async {
                    mainImage.image = UIImage(data: data)
                }
            } else {
                print("Error loading image")
            }
        }
    
        let ingridientsLabel = UILabel()
        ingridientsLabel.text = "INGRIDIENTS"
        ingridientsLabel.frame.origin = CGPoint(x: 5, y: mainImage.frame.origin.y + mainImage.frame.size.height)
        ingridientsLabel.backgroundColor = UIColor(red: 0.21, green: 0.58, blue: 0.49, alpha: 1.00)
        ingridientsLabel.layer.cornerRadius = 10
        ingridientsLabel.textAlignment = .center
        ingridientsLabel.textColor = UIColor(red: 0.92, green: 0.93, blue: 0.93, alpha: 1.00)
        ingridientsLabel.layer.masksToBounds = true
        ingridientsLabel.frame.size = CGSize(width: self.view.frame.size.width - 10, height: 30)
        recipeScrollView.addSubview(ingridientsLabel)
        
        //var labelOriginY = ingridientsLabel.frame.origin.y + ingridientsLabel.frame.size.height
        var labelOriginY = ingridientsLabel.frame.origin.y + ingridientsLabel.frame.size.height
        let missedIngridients = recipes?.missedIngredients
        if let ingridients = missedIngridients {
            for ingridient in ingridients {
                let textBackground = UIView()
                textBackground.frame.size.width = self.view.frame.size.width - 10
                textBackground.frame.size.height = 30
                textBackground.frame.origin.x = 5
                textBackground.frame.origin.y = labelOriginY
                labelOriginY += 30
                //textBackground.backgroundColor = .cyan
                
                let label = UILabel()
                label.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - self.view.frame.size.width/3 - 5, height: 30)
                label.text = ingridient.name
                label.textAlignment = .left
                
                let countLabel = UILabel()
                countLabel.frame = CGRect(x: label.frame.size.width, y: 0, width: self.view.frame.size.width/3 - 5, height: 30)
                let countLabelText = String(format: "%.1f", ingridient.amount) + " " + ingridient.unitShort
                countLabel.text = countLabelText
                countLabel.textAlignment = .right
                
                textBackground.addSubview(label)
                textBackground.addSubview(countLabel)
                recipeScrollView.addSubview(textBackground)
            }
        }
        
        let preparationLabel = UILabel()
        preparationLabel.text = "PREPARATION"
        preparationLabel.frame.origin = CGPoint(x: 5, y: labelOriginY + 30)
        preparationLabel.backgroundColor = UIColor(red: 0.21, green: 0.58, blue: 0.49, alpha: 1.00)
        preparationLabel.layer.cornerRadius = 10
        preparationLabel.textAlignment = .center
        preparationLabel.textColor = UIColor(red: 0.92, green: 0.93, blue: 0.93, alpha: 1.00)
        preparationLabel.layer.masksToBounds = true
        preparationLabel.frame.size = CGSize(width: self.view.frame.size.width - 10, height: 30)
        recipeScrollView.addSubview(preparationLabel)
        
        labelOriginY = preparationLabel.frame.origin.y + preparationLabel.frame.size.height
        
        let preparationSteps = recipes?.analyzedInstructions[0].steps
        if let steps = preparationSteps {
            for step in steps {
                let textBackground = UIView()
                textBackground.frame.size.width = self.view.frame.size.width - 10
                textBackground.frame.size.height = 60
                textBackground.frame.origin.x = 5
                textBackground.frame.origin.y = labelOriginY
                labelOriginY += 30
                //textBackground.backgroundColor = .cyan
                
                let label = UILabel()
                label.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width / 5, height: 30)
                label.text = String(step.number)
                label.textAlignment = .left
                
                let countLabel = UILabel()
                countLabel.frame = CGRect(x: label.frame.size.width, y: 0, width: self.view.frame.size.width - self.view.frame.size.width / 5, height: 30)
                let countLabelText = step.step
                countLabel.text = countLabelText
                countLabel.textAlignment = .left
                countLabel.numberOfLines = 2
                
                textBackground.addSubview(label)
                textBackground.addSubview(countLabel)
                recipeScrollView.addSubview(textBackground)
            }
        }
        
    }
    
    func getFavouritesRecipes() -> [String]? {
        let favouritesRecipeIds = UserDefaults.standard.stringArray(forKey: favouritesKey)
        return favouritesRecipeIds
    }
    
    func saveFavouritesRecipes(ids: [String]) {
        UserDefaults.standard.set(ids, forKey: favouritesKey)
    }
    
    func checkIfIsFavouriteRecipe(id: String) -> Bool {
        let favouritesRecipeIds = getFavouritesRecipes() ?? [String]()
        for recipe in favouritesRecipeIds {
            print(recipe)
            if (recipe == id) {
                return true
            }
        }
        return false
    }
        
    func addRecipeToFavourites(id: String) {
        var favouritesRecipeIds = getFavouritesRecipes() ?? [String]()
        favouritesRecipeIds.append(id)
        saveFavouritesRecipes(ids: favouritesRecipeIds)
    }
    
    func removeRecipeFromFavourites(id: String) {
        var favouritesRecipeIds = getFavouritesRecipes() ?? [String]()
        favouritesRecipeIds = favouritesRecipeIds.filter{ $0 != id } //New array filtered by any element of array equals id, if yes - remove that id and save this array
        saveFavouritesRecipes(ids: favouritesRecipeIds)
        
    }

}
