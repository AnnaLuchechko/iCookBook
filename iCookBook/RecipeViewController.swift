//
//  RecipeViewController.swift
//  iCookBook
//
//  Created by Anna Luchechko on 11.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class RecipeViewController: UIViewController {

    var imageURL: String = ""
    let recipesData = RecipeData()
    var recipe: Recipe?
    
    @IBOutlet weak var recipeNavigationItem: UINavigationItem!
    @IBOutlet weak var recipeScrollView: UIScrollView!
    @IBOutlet weak var favouriteButtonReference: UIButton!
    
    @IBAction func favouriteButton(_ sender: UIButton) {
        if (recipesData.checkIfIsFavouriteRecipe(id: String(recipe?.id ?? 0))) {
            recipesData.removeRecipeFromFavourites(id: String(recipe?.id ?? 0))
            favouriteButtonReference.setImage(UIImage(named: "heart"), for: .normal)
        } else {
            recipesData.addRecipeToFavourites(id: String(recipe?.id ?? 0), recipe: self.recipe!)
            favouriteButtonReference.setImage(UIImage(named: "heartfilled"), for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if (recipesData.checkIfIsFavouriteRecipe(id: String(recipe?.id ?? 0))) {
            favouriteButtonReference.setImage(UIImage(named: "heartfilled"), for: .normal)
        } else {
            favouriteButtonReference.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeNavigationItem.title = recipe?.title.uppercased() //Recipe title
        navigationController?.navigationBar.topItem?.title = " "
        
        let mainImage = UIImageView()   //Recipe image
        mainImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        mainImage.contentMode = .scaleAspectFill
        recipeScrollView.backgroundColor = .saturatedGreenColor
        recipeScrollView.addSubview(mainImage)

        let imageUrl = URL(string: imageURL)   //Get image from API for recipe
        
        let imageResource = ImageResource(downloadURL: imageUrl!, cacheKey: imageURL)
        mainImage.kf.setImage(with: imageResource)  //Using Library Kingfisher to cache image
    
        let ingridientsLabel = UILabel()    //Ingredients settings for recipe
        ingridientsLabel.text = "INGRIDIENTS"
        ingridientsLabel.frame.origin = CGPoint(x: 5, y: mainImage.frame.origin.y + mainImage.frame.size.height + 2)
        ingridientsLabel.backgroundColor = .unSaturadedGreenColor
        ingridientsLabel.layer.cornerRadius = 10
        ingridientsLabel.textAlignment = .center
        ingridientsLabel.textColor = .saturatedGreenColor
        ingridientsLabel.layer.masksToBounds = true
        ingridientsLabel.frame.size = CGSize(width: self.view.frame.size.width - 10, height: 30)
        recipeScrollView.addSubview(ingridientsLabel)
        
        var labelOriginY = ingridientsLabel.frame.origin.y + ingridientsLabel.frame.size.height
        let missedIngridients = recipe?.missedIngredients
        if let ingridients = missedIngridients {
            for ingridient in ingridients {
                let textBackground = UIView()
                textBackground.frame.size.width = self.view.frame.size.width - 10
                textBackground.frame.size.height = 30
                textBackground.frame.origin.x = 5
                textBackground.frame.origin.y = labelOriginY
                labelOriginY += 30
                //textBackground.backgroundColor = .cyan
                
                let bottomBorder = UIView()
                bottomBorder.frame = CGRect(x: 0, y: textBackground.frame.size.height, width: textBackground.frame.size.width, height: 1)
                bottomBorder.backgroundColor = .unSaturadedGreenColor
                textBackground.addSubview(bottomBorder) //Add lines for each ingredient
                
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
        
        let preparationLabel = UILabel()    //Prearation settings for recipe
        preparationLabel.text = "PREPARATION"
        preparationLabel.frame.origin = CGPoint(x: 5, y: labelOriginY + 5)
        preparationLabel.backgroundColor = .unSaturadedGreenColor
        preparationLabel.layer.cornerRadius = 10
        preparationLabel.textAlignment = .center
        preparationLabel.textColor = .saturatedGreenColor
        preparationLabel.layer.masksToBounds = true
        preparationLabel.frame.size = CGSize(width: self.view.frame.size.width - 10, height: 30)
        recipeScrollView.addSubview(preparationLabel)
        
        labelOriginY = preparationLabel.frame.origin.y + preparationLabel.frame.size.height + 2
        
        let preparationSteps = recipe?.analyzedInstructions[0].steps
        if let steps = preparationSteps {
            for step in steps {
                let textBackground = UIView()
                textBackground.frame.size.width = self.view.frame.size.width - 10
                textBackground.frame.size.height = 30
                textBackground.frame.origin.x = 5
                textBackground.frame.origin.y = labelOriginY
                textBackground.backgroundColor = .cellGrey
                textBackground.layer.masksToBounds = true
                textBackground.layer.cornerRadius = 10
                
                                
                let label = UILabel()
                label.frame = CGRect(x: 5, y: 0, width: self.view.frame.size.width / 14, height: 30)
                label.text = String(step.number)
                label.textAlignment = .left
                
                let countLabel = UILabel()
                countLabel.frame = CGRect(x: label.frame.size.width, y: 0, width: self.view.frame.size.width - self.view.frame.size.width / 10, height: 30)
                let countLabelText = step.step
                countLabel.text = countLabelText
                countLabel.textAlignment = .left
                countLabel.numberOfLines = countLabel.maxNumberOfLines
                countLabel.frame.size.height = countLabel.frame.size.height * CGFloat(countLabel.maxNumberOfLines)
                label.frame.size.height = label.frame.size.height * CGFloat(countLabel.maxNumberOfLines)
                textBackground.frame.size.height = countLabel.frame.size.height
                labelOriginY += textBackground.frame.size.height + 2
                
                
                textBackground.addSubview(label)
                textBackground.addSubview(countLabel)
                recipeScrollView.addSubview(textBackground)
            }
        }
        
        recipeScrollView.contentSize = CGSize(width: self.view.frame.width, height: labelOriginY + 2)
    }
    
}

extension UILabel { //Extend UILabel code to get needed number of lines to display whole text
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font!], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}
