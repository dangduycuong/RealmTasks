//
//  APIType.swift
//  RealmTasks
//
//  Created by cuongdd on 23/2/25.
//

import Foundation

protocol APIType {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var bodyDictionary: Dictionary<String, Any>? { get }
    var bodyData: Codable? { get }
    var queryItems: [URLQueryItem]? { get }
    var method: String { get }
    var headers: [String: String]? { get }
}
