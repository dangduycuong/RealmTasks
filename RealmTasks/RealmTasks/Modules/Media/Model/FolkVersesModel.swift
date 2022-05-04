//
//  FolkModel.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import Foundation
import RealmSwift

class FolkTypeModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var fileName: String = ""
    @objc dynamic var title: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

class FolkVersesModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var fileName: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    
    @objc dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
