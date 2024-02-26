//
//  PoemModel.swift
//  RealmTasks
//
//  Created by cuongdd on 20/02/2024.
//

import Foundation

// MARK: - PoemModel
struct PoemModel: Codable {
    var author: String?
    var poems: [Poem]?
}

// MARK: - Poem
struct Poem: Codable {
    var title, content, note: String?
}

