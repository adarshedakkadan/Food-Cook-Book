//
//  FCBEndPoints.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import Foundation

struct FCBEndPoints {
    static let rootUrl = "https://www.themealdb.com/"
    
    static func productDetails(identifier: String) -> String {
        return rootUrl + "api/json/v1/1/lookup.php?i=" + identifier
    }
    
    static func search(name: String) -> String {
        return rootUrl + "api/json/v1/1/search.php?s=" + name
    }
    
    static let getAllCategories = rootUrl + "api/json/v1/1/list.php?c=list"
    static func getFoodWithCategory(name: String) -> String {
        return rootUrl + "api/json/v1/1/filter.php?c=" + name
    }
    
}
