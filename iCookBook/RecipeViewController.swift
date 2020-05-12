//
//  RecipeViewController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 11.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    //@IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeScrollView: UIScrollView!
    //@IBOutlet weak var ingridientsLabel: UILabel!
    var imageURL: String = ""
    let recipesData = RecipeData()
    var recipes: Recipes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeScrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        
        let mainImage = UIImageView()
        mainImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        mainImage.contentMode = .scaleAspectFill
        recipeScrollView.backgroundColor = .gray
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
        ingridientsLabel.backgroundColor = .white
        ingridientsLabel.layer.cornerRadius = 10
        ingridientsLabel.textAlignment = .center
        ingridientsLabel.textColor = .cyan
        ingridientsLabel.layer.masksToBounds = true
        ingridientsLabel.frame.size = CGSize(width: self.view.frame.size.width - 10, height: 30)
        recipeScrollView.addSubview(ingridientsLabel)
        
        //var labelOriginY = ingridientsLabel.frame.origin.y + ingridientsLabel.frame.size.height
        var labelOriginY = ingridientsLabel.frame.origin.y + ingridientsLabel.frame.size.height
        let missedIngridients = recipes?.results[0].missedIngredients
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
        
        
        
    }

}
