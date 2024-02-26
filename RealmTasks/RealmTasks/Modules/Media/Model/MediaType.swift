//
//  MediaType.swift
//  RealmTasks
//
//  Created by cuongdd on 25/02/2024.
//

import Foundation

enum MediaType {
    case folkVerses
    case proverb
    case poem
    
    static let list = [folkVerses, proverb, poem]
    
    var text: String {
        get {
            switch self {
            case .folkVerses:
                return R.string.localizable.folkVerses().language()
            case .proverb:
                return R.string.localizable.proverb().language()
            case .poem:
                return "Thơ"
            }
        }
    }
    
    var value: String {
        get {
            switch self {
            case .folkVerses:
                return "folkVerses"
            case .proverb:
                return "proverb"
            case .poem:
                return "poem"
            }
        }
    }
}
