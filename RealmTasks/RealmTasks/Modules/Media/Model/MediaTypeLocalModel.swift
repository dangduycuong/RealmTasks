//
//  MediaTypeLocalModel.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import Foundation
import RealmSwift

class MediaTypeLocalModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var fileName: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var mediaType: String = "folkVerses"
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
