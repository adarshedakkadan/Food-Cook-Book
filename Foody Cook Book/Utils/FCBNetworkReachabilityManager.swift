//
//  FCBNetworkReachabilityManager.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import Foundation
import Reachability

class NetworkReachabilityManager: NSObject {
    var reachability: Reachability!
    private static let shared: NetworkReachabilityManager = { return NetworkReachabilityManager() }()
    override init() {
        super.init()
        do {
            reachability = try Reachability()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    static func isReachable(completed: @escaping (Bool) -> Void) {
        if (NetworkReachabilityManager.shared.reachability).connection != .unavailable {
            completed(true)
        } else {
            completed(false)
        }
    }
}

