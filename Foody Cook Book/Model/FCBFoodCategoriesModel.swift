//
//  FCBFoodCategoriesModel.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import Foundation
struct FCBFoodCategoriesModel: Codable {
    let meals: [FCBMealCategory]
}

// MARK: - Meal
struct FCBMealCategory: Codable {
    let strCategory: String
}
