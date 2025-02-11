//
//  LanguageResponseModel.swift
//  RealmTasks
//
//  Created by cuongdd on 11/2/25.
//

import Foundation

struct LanguageResponseModel: Codable {
    var trans: TransModel?
}

struct TransModel: Codable {
    var address, lastUpdated, tempC, humidity, wind, feelsLike, text: String?
}
