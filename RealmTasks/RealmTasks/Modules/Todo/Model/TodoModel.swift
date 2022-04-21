//
//  TodoModel.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import RealmSwift

class TodoModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var todoTitle: String = ""
    @objc dynamic var todoDescription: String = ""
    @objc dynamic var isCompleted: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
