//
//  ProverbModel.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import RealmSwift

class ProverbModel: Object {
    
    @objc dynamic var nameDocumentType: String = ""
    @objc dynamic var loadDocument: Bool = true
    @objc dynamic var idDocumentType: Int = 0
    
    override static func primaryKey() -> String? {
        return "idDocumentType"
    }
    
}
