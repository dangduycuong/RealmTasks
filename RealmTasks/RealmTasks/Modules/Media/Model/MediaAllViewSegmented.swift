//
//  MediaAllViewSegmented.swift
//  RealmTasks
//
//  Created by cuongdd on 25/02/2024.
//

import Foundation

enum MediaAllViewSegmented {
    case all
    case folkVerses
    case proverb
    case favorite
    
    static let list = [all, folkVerses, proverb, favorite]
    
    var text: String {
        get {
            switch self {
            case .all:
                return "All"
            case .folkVerses:
                return "Ca Dao"
            case .proverb:
                return "Tục Ngữ"
            case .favorite:
                return "Yêu Thích"
            }
        }
    }
}
