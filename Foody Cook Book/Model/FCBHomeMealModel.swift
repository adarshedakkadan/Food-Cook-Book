//
//  FCBHomeMealModel.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import Foundation


struct FCBHomeMealModel: Codable {
    let meals: [FCBHomeMeal]
}

// MARK: - Meal
class FCBHomeMeal: NSObject, NSCoding, Codable {
    
    
    required convenience init?(coder: NSCoder) {
        let mealName = coder.decodeObject(forKey: "strMeal") as! String
        let thumbImage = coder.decodeObject(forKey: "strMealThumb") as! String
        let mealId = coder.decodeObject(forKey: "idMeal") as! String
        let favorite = coder.decodeObject(forKey: "isFavorite") as? Bool
        self.init(strMeal: mealName, strMealThumb: thumbImage, idMeal: mealId, isFavorite: favorite)
    }
    
    init(strMeal: String, strMealThumb: String, idMeal: String, isFavorite: Bool?) {
        
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
        self.isFavorite = isFavorite
    }
    
    
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    var isFavorite: Bool?
    
    func encode(with coder: NSCoder) {
        coder.encode(strMeal, forKey: "strMeal")
        coder.encode(idMeal, forKey: "idMeal")
        coder.encode(strMealThumb, forKey: "strMealThumb")
        coder.encode(isFavorite, forKey: "isFavorite")
    }
}
