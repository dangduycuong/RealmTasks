//
//  WeatherEndpoint.swift
//  RealmTasks
//
//  Created by cuongdd on 23/2/25.
//

import Foundation

enum WeatherEndpoint {
    case realtimeWeather(queryItems: [URLQueryItem])
}

extension WeatherEndpoint: APIType {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "weatherapi-com.p.rapidapi.com"
    }
    
    var path: String {
        switch self {
        case .realtimeWeather:
            return "/current.json"
        }
    }
    
    var bodyDictionary: Dictionary<String, Any>? {
        switch self {
        default:
            return nil
        }
    }
    
    var bodyData: (any Codable)? {
        switch self {
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .realtimeWeather(let queryItems):
            return queryItems
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [
                "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
                "X-RapidAPI-Key": "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa"
            ]
        }
    }
}
