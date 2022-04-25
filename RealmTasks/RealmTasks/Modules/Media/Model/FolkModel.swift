//
//  FolkModel.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import Foundation
import RealmSwift

struct FolkTypeModel {
    var fileName: String?
    var title: String?
}

struct FolkModel {
    var id: String = ""
    var fileName: String?
    var title: String?
    var content: String?
    var isFavorite: Bool = false
}

class FavoriteFolkModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var fileName: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    
    var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
