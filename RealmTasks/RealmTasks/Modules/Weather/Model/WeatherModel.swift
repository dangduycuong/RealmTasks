//
//  WeatherModel.swift
//  RealmTasks
//
//  Created by cuongdd on 25/02/2024.
//

import Foundation

struct WeatherModel: Codable {
    var folks: [WeatherContentModel]?
    var proverbs: [WeatherContentModel]?
}

// MARK: - Poem
struct WeatherContentModel: Codable {
    var content, explain: String?
    var isShowing: Bool?
}
