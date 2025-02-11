//
//  LangueRequestModel.swift
//  RealmTasks
//
//  Created by cuongdd on 11/2/25.
//

import Foundation

struct LangueRequestModel: Codable {
    var protectedPaths: [String]?
    var from: String?
    var json: Content?
    var to: String?
    var commonProtectedPaths: [String]?
    
    enum CodingKeys: String, CodingKey {
        case protectedPaths = "protected_paths"
        case from, json, to
        case commonProtectedPaths = "common_protected_paths"
    }
}

struct Content: Codable {
    var address, lastUpdated, tempC, feelsLike, humidity, wind, text: String?
}
