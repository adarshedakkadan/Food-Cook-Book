//
//  FCBSearchFoodService.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 22/04/3 R.
//

import Foundation

final class FCBSearchFoodService: FCBNetworkManager <FCBSearch> {
    func request(name: String,completion: @escaping RequestCompletion) {
        requestUrl = FCBEndPoints.search(name: name)
        requestMethod = .get
        formatterRequired = false
        super.perform(completion: completion)
    }
}
