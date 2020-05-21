//
//  DiscoverViewController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 04.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var recipesCollectionView: UICollectionView!

    var recipes: Recipes?
    
    var shownFromCategories = false //Bool: true if we go from categories, false - we go from discover
    
    let recipeData = RecipeData()
    
    let searchController = UISearchController()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadRecipes(recipe: searchBar.text!)
        searchController.searchBar.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        shownFromCategories = false //we go out from discover
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesCollectionView.backgroundColor = .saturatedGreenColor
        recipesCollectionView.delegate = self //DiscoveViewController responsible for UICollectionViewDelegate functions
        recipesCollectionView.dataSource = self //DiscoveViewController responsible for UICollectionViewDataSource functions
        
        if(!shownFromCategories) {
            loadRecipes(recipe: "potatoe") //we go to discover
        }

        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string:"Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        searchController.searchBar.searchTextField.textColor = UIColor.white
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.tintColor = .saturatedGreenColor
        
        let title = UIImage(named: "title.png")  //Title logo
        let imageView = UIImageView(image:title)
        self.navigationItem.titleView = imageView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        recipesCollectionView.addGestureRecognizer(tap)
        recipesCollectionView.isUserInteractionEnabled = true //
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {    //Tap on Recipe in DiscoverView
       if let indexPath = self.recipesCollectionView?.indexPathForItem(at: sender.location(in: self.recipesCollectionView)) {
            let recipeViewController = storyboard?.instantiateViewController(identifier: "RecipeViewController") as? RecipeViewController
            let imageURLString = "https://spoonacular.com/recipeImages/" + String((recipes?.results[indexPath.row].id)!) + "-556x370.jpg"
            recipeViewController?.imageURL = imageURLString
            recipeViewController?.recipe = self.recipes?.results[indexPath.row]
            self.navigationController?.show(recipeViewController!, sender: self)
        }
    }

    func loadRecipes(recipe: String) {
        if let soonacularApiURL = URL(string: self.recipeData.spoonacoolarApiURL(query: recipe)) {
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

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {    //Settings of CollectionView
    
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
        
        if ((recipes?.results.count)! > 0) {
            let recipe = recipes?.results[indexPath.row]
            cell.recipeCellLabel.text = recipe?.title
            
            let imageResource = ImageResource(downloadURL: recipe!.image, cacheKey: recipe!.image.absoluteString)
            cell.recipeCellImageView.kf.setImage(with: imageResource)  //Using Library Kingfisher to cache image
    
        }
        return cell
    }
}
