//
//  WeatherSegmentedType.swift
//  RealmTasks
//
//  Created by cuongdd on 25/02/2024.
//

import Foundation

enum WeatherSegmentedType {
    case map
    case folk
    case proverb
    
    static let all = [map, folk, proverb]
    
    var title: String {
        switch self {
        case .map:
            return "Bản Đồ"
        case .folk:
            return "Ca Dao"
        case .proverb:
            return "Tục Ngữ"
        }
    }
}
