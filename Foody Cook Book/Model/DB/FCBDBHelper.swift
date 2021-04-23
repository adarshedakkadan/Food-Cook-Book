//
//  FCBDBHelper.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import Foundation

class FCBDBHelper: NSObject {
    
    static func storeValues(meals: [FCBHomeMeal]) {
        let userDefaults = UserDefaults.standard
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
            userDefaults.set(encodedData, forKey: "meals")
            userDefaults.synchronize()
        } catch { print(error) }
    }
    
    static func getMeals() -> [FCBHomeMeal]? {
        
        let userDefaults = UserDefaults.standard
        do {
            if let decoded  = userDefaults.data(forKey: "meals") {
                let decodedMeals = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded)  as? [FCBHomeMeal]
                return decodedMeals
            }
        } catch { print(error) }
        return nil
    }
    
    static func clearAllDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    
}
