//
//  WisdomModel.swift
//  RealmTasks
//
//  Created by cuongdd on 06/05/2022.
//

import RealmSwift

class WisdomModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var content: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
