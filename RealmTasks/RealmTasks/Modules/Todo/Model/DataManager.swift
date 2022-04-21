//
//  DataManager.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import RealmSwift

class DataManager: NSObject {
    static let shared = DataManager()
    let realm = try! Realm()
    
    func addDataToRealm(_ todo: TodoModel) {
        try! realm.write {
            realm.add(todo)
        }
    }
    
    func modifyDataRealm(dataEdit: TodoModel) {
        let listData = realm.objects(TodoModel.self)
        realm.beginWrite()
        for item in listData {
            if item.id == dataEdit.id {
                item.todoTitle = dataEdit.todoTitle
                item.todoDescription = dataEdit.todoDescription
                item.isCompleted = dataEdit.isCompleted
            }
        }
        try! realm.commitWrite()
    }
    
    func getListDataFromRealm(_ completionHandler: @escaping ([TodoModel]) -> Void ) {
        var listData = [TodoModel]()
        let todo = realm.objects(TodoModel.self)
        for item in todo {
            listData.append(item)
        }
        completionHandler(listData)
    }
    
    func removeDocumentOffline(id: String) -> Bool {
        guard let todo = realm.objects(TodoModel.self).filter({$0.id == id}).first else { return false }
        try! realm.write {
            realm.delete(todo)
        }
        return true
    }
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
