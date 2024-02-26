//
//  MapType.swift
//  RealmTasks
//
//  Created by cuongdd on 25/02/2024.
//

import Foundation

enum MapType {
    case normal
    case satellite
    case terrain
    case hybrid
    case noneNormal
    
    static let all = [normal, satellite, terrain, hybrid, noneNormal]
    
    var text: String {
        get {
            switch self {
            case .normal:
                return "Normal"
            case .satellite:
                return "Satellite"
            case .terrain:
                return "Terrain"
            case .hybrid:
                return "Hybrid"
            case .noneNormal:
                return "None"
            }
        }
    }
}
