//
//  MediaDetailLocalModel.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import Foundation
import RealmSwift

class MediaDetailLocalModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var fileName: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var mediaType: String = "folkVerses"
    
    @objc dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
