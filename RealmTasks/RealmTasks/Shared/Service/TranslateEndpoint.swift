//
//  TranslateEndpoint.swift
//  RealmTasks
//
//  Created by cuongdd on 23/2/25.
//

import Foundation

enum TranslateEndpoint {
    case translateJSON(model: LangueRequestModel)
}

extension TranslateEndpoint: APIType {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "google-translate113.p.rapidapi.com"
    }
    
    var path: String {
        switch self {
        case .translateJSON:
            return "/api/v1/translator/json"
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
        case .translateJSON(let model):
            return model
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var method: String {
        switch self {
        default:
            return "POST"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [
                "x-rapidapi-key": "b266514becmsh63278b22c117acfp12ef2cjsn7a142a5dffa4",
                "x-rapidapi-host": "google-translate113.p.rapidapi.com",
                "Content-Type": "application/json"
            ]
        }
    }
}
