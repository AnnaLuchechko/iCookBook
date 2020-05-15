//
//  Recipes.swift
//  iCookBook
//
//  Created by Anna Luchechko on 05.05.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//
import Foundation

struct Recipes: Codable {
    let results: [Recipe]
    let number: Int
}

struct Recipe: Codable {
    let readyInMinutes: Int
    let id: Int
    let title: String
    let servings: Int
    let image: URL
    let dishTypes: [String]
    let analyzedInstructions: [AnalyzedInstruction]
    let missedIngredientCount: Int
    let missedIngredients: [MissedIngredient]
}

struct AnalyzedInstruction: Codable {
    let name: String
    struct Step: Codable {
        let number: Int
        let step: String
        struct Ingredient: Codable {
            let id: Int
            let name: String
            let image: String
        }
        let ingredients: [Ingredient]
    }
    let steps: [Step]
}

struct MissedIngredient: Codable {
    let id: Int
    let amount: Double
    let unit: String
    let unitShort: String
    let name: String
    let original: String
    
}
