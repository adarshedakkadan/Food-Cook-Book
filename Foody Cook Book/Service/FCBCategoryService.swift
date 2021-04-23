//
//  FCBCategoryService.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import Foundation
final class FCBCategoryService: FCBNetworkManager <FCBFoodCategoriesModel> {
    func request(completion: @escaping RequestCompletion) {
        requestUrl = FCBEndPoints.getAllCategories
        requestMethod = .get
        formatterRequired = false
        super.perform(completion: completion)
    }
}
