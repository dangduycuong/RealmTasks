//
//  DiaryModel.swift
//  RealmTasks
//
//  Created by cuongdd on 25/02/2024.
//

import Foundation
import RealmSwift

class DiaryModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var dateTime: Date = Date.now
    @objc dynamic var upDateTime: Date?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
