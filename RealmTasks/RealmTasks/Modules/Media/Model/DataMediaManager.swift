//
//  DataMediaManager.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import RealmSwift

class DataMediaManager: NSObject {
    static let shared = DataMediaManager()
    let realm = try! Realm()
    
    func addFolkToRealm(_ data: FavoriteFolkModel) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getListFavoriteFolkFromRealm(_ completionHandler: @escaping ([FavoriteFolkModel]) -> Void ) {
        var listData = [FavoriteFolkModel]()
        let todo = realm.objects(FavoriteFolkModel.self)
        for item in todo {
            listData.append(item)
        }
        completionHandler(listData)
    }
    
    func removeDataMedia(id: String) -> Bool {
        guard let todo = realm.objects(TodoModel.self).filter({$0.id == id}).first else { return false }
        try! realm.write {
            realm.delete(todo)
        }
        return true
    }
    
}
