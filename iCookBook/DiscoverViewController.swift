//
//  DiscoverViewController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 04.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var recipesCollectionView: UICollectionView!

    var recipes: Recipes?
    
    let recipeData = RecipeData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesCollectionView.delegate = self   //DiscoveViewController responsible for UICollectionViewDelegate functions
        recipesCollectionView.dataSource = self //DiscoveViewController responsible for UICollectionViewDataSource functions
        
        loadRecipes()
    }
    
    func loadRecipes() {
        if let soonacularApiURL = URL(string: self.recipeData.spoonacoolarApiURL(query: "omelet")) {
            self.recipeData.fetchDataFromURL(from: soonacularApiURL) { (recipesData) in
                if let data = recipesData {
                    DispatchQueue.main.async {  //Run asynchronous process on main thread
                        self.recipes = try? JSONDecoder().decode(Recipes.self, from: data)  //Decode json -> struct Recipes -> recipes
                        self.recipesCollectionView.reloadData()
                    }
                } else {
                    print("Error loading recipes structure");
                }
            }
        } else {
            print("error creating url for API")
        }
    }
    
}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.view.frame.size.width
        let cellWidth = screenWidth / 2 - 10
        return CGSize(width: cellWidth, height: cellWidth + 40) //+40 is customed for label
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.number ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeViewCell", for: indexPath) as! RecipeCollectionViewCell
        //Each cell in collection view
        
        let screenWidth = self.view.frame.size.width
        let cellWidth = screenWidth / 2 - 10
        
        cell.recipeCellImageView.frame.size.width = cellWidth
        cell.recipeCellImageView.frame.size.height = cellWidth
        cell.recipeCellLabel.frame.origin.y = cell.recipeCellImageView.frame.origin.y + cellWidth //Label Y = Origin Y + Image size Y
        cell.recipeCellImageView.layer.cornerRadius = 10    //Round bounds
        cell.recipeCellImageView.layer.masksToBounds = true
        
        let recipe = recipes?.results[indexPath.row]
        cell.recipeCellLabel.text = recipe?.title
        self.recipeData.fetchDataFromURL(from: (recipe?.image)!) { (imageData) in //Fetch image for cell
            if let data = imageData {
                DispatchQueue.main.async {
                    cell.recipeCellImageView.image = UIImage(data: data)
                }
            } else {
                print("Error loading image");
            }
        }
        return cell
    }
}
