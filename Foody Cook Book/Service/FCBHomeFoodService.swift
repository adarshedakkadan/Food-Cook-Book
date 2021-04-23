//
//  FCBHomeFoodService.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 22/04/3 R.
//

import Foundation

final class FCBHomeFoodService: FCBNetworkManager <FCBHomeMealModel> {
    func request(name: String, completion: @escaping RequestCompletion) {
        requestUrl = FCBEndPoints.getFoodWithCategory(name: name)
        requestMethod = .get
        formatterRequired = false
        super.perform(completion: completion)
    }
}

final class FCBMealDetailsService: FCBNetworkManager <FCBSearchModel> {
    func request(identifier: String, completion: @escaping RequestCompletion) {
        requestUrl = FCBEndPoints.productDetails(identifier: identifier)
        requestMethod = .get
        formatterRequired = false
        super.perform(completion: completion)
    }
}
