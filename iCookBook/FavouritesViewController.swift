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
    var favouriteRecipes = [Recipe]()

    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.tintColor = UIColor(red: 0.92, green: 0.93, blue: 0.93, alpha: 1.00)
        
        favouritesCollectionView.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.93, alpha: 1.00)
        favouritesCollectionView.delegate = self //FavouritesViewController responsible for UICollectionViewDelegate functions
        favouritesCollectionView.dataSource = self //FavouritesViewController responsible for UICollectionViewDataSource functions
        
        favouriteRecipes = recipesData.getRecipeData()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        favouritesCollectionView.addGestureRecognizer(tap)
        favouritesCollectionView.isUserInteractionEnabled = true //
    }
        
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
       if let indexPath = self.favouritesCollectionView?.indexPathForItem(at: sender.location(in: self.favouritesCollectionView)) {
            let recipeViewController = storyboard?.instantiateViewController(identifier: "RecipeViewController") as? RecipeViewController
            let imageURLString = "https://spoonacular.com/recipeImages/" + String(favouriteRecipes[indexPath.row].id) + "-556x370.jpg"
            recipeViewController?.imageURL = imageURLString
            recipeViewController?.recipe = self.favouriteRecipes[indexPath.row]
            self.navigationController?.pushViewController(recipeViewController!, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favouriteRecipes = recipesData.getRecipeData()
               self.favouritesCollectionView.reloadData()
    }

}

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.view.frame.size.width
        let cellWidth = screenWidth
        return CGSize(width: cellWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouritesViewCell", for: indexPath) as! FavouritesCollectionViewCell
        //Each cell in collection view
        
        //let screenWidth = self.view.frame.size.width
        //let cellWidth = screenWidth
        //cell.favouritesImageView.frame.size.width = cellWidth
        //cell.favouritesImageView.frame.size.height = cellWidth
        //cell.favouritesLabelView.frame.origin.y = cell.recipeCellImageView.frame.origin.y + cellWidth //Label Y = Origin Y + Image size Y
        cell.favouritesImageView.layer.cornerRadius = 10    //Round bounds
        cell.favouritesImageView.layer.masksToBounds = true
        cell.contentView.backgroundColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.00)
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        
        if (favouriteRecipes.count > 0) {
            let recipe = favouriteRecipes[indexPath.row]
            cell.favouritesLabelView.text = recipe.title
            self.recipesData.fetchDataFromURL(from: recipe.image) { (imageData) in //Fetch image for cell
                if let data = imageData {
                    DispatchQueue.main.async {
                        cell.favouritesImageView.image = UIImage(data: data)
                    }
                } else {
                    print("Error loading image");
                }
            }
        }
        return cell
    }
}
