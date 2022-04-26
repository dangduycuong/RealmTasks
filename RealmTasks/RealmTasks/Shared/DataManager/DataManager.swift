//
//  DataManager.swift
//  RealmTasks
//
//  Created by cuongdd on 26/04/2022.
//

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
    
    //MARK: - FolkType
    func addFolkTypeToRealm(_ data: FolkTypeModel) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getListFolkType(_ completionHandler: @escaping ([FolkTypeModel]) -> Void ) {
        var listData = [FolkTypeModel]()
        let todo = realm.objects(FolkTypeModel.self)
        for item in todo {
            listData.append(item)
        }
        completionHandler(listData)
    }
    
    func removeFolkType(id: String) -> Bool {
        guard let todo = realm.objects(FolkTypeModel.self).filter({$0.id == id}).first else { return false }
        try! realm.write {
            realm.delete(todo)
        }
        return true
    }
    //MARK: - Folk
    func addFolkToRealm(_ data: FolkModel) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func modifyFolk(dataEdit: FolkModel) {
        let listData = realm.objects(FolkModel.self)
        realm.beginWrite()
        
        if let i = listData.firstIndex(where: { $0.id == dataEdit.id }) {
            print("\(listData[i])")
        }
        for item in listData {
            if item.id == dataEdit.id {
                item.fileName = dataEdit.fileName
                item.title = dataEdit.title
                item.content = dataEdit.content
                item.isFavorite = dataEdit.isFavorite
            }
        }
        try! realm.commitWrite()
    }
    
    func getListFolk(_ completionHandler: @escaping ([FolkModel]) -> Void ) {
        var listData = [FolkModel]()
        let todo = realm.objects(FolkModel.self)
        for item in todo {
            listData.append(item)
        }
        completionHandler(listData)
    }
    
    func removeFolk(id: String) -> Bool {
        guard let folk = realm.objects(FolkModel.self).filter({$0.id == id}).first else { return false }
        try! realm.write {
            realm.delete(folk)
        }
        return true
    }
    
    //MARK: - ProverbType
    func addProverbType(_ data: ProverbTypeModel) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getListProverbType(_ completionHandler: @escaping ([ProverbTypeModel]) -> Void ) {
        var listData = [ProverbTypeModel]()
        let proverbType = realm.objects(ProverbTypeModel.self)
        for item in proverbType {
            listData.append(item)
        }
        completionHandler(listData)
    }
    
    func removeProverbType(id: String) -> Bool {
        guard let proverbType = realm.objects(ProverbTypeModel.self).filter({$0.id == id}).first else { return false }
        try! realm.write {
            realm.delete(proverbType)
        }
        return true
    }
    
    //MARK: - Proverbs
    func addProverb(_ data: ProverbModel) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func modifyProverb(dataEdit: ProverbModel) {
        let listData = realm.objects(ProverbModel.self)
        realm.beginWrite()
        for item in listData {
            if item.id == dataEdit.id {
                item.fileName = dataEdit.fileName
                item.title = dataEdit.title
                item.content = dataEdit.content
                item.isFavorite = dataEdit.isFavorite
            }
        }
        try! realm.commitWrite()
    }
    
    func getListProverb(_ completionHandler: @escaping ([ProverbModel]) -> Void ) {
        var listData = [ProverbModel]()
        let proverbType = realm.objects(ProverbModel.self)
        for item in proverbType {
            listData.append(item)
        }
        completionHandler(listData)
    }
    
    func removeProverb(id: String) -> Bool {
        guard let proverbType = realm.objects(ProverbModel.self).filter({$0.id == id}).first else { return false }
        try! realm.write {
            realm.delete(proverbType)
        }
        return true
    }
    
    func deleteFolkType(completion: @escaping () -> Void) {
        self.realm.beginWrite()
        let folkTypeModel = self.realm.objects(FolkTypeModel.self)
        self.realm.delete(folkTypeModel)
        try! self.realm.commitWrite()
        completion()
    }
    
    func deleteProverbType(completion: @escaping () -> Void) {
        self.realm.beginWrite()
        let proverbTypeModel = self.realm.objects(ProverbTypeModel.self)
        self.realm.delete(proverbTypeModel)
        try! self.realm.commitWrite()
        completion()
    }
    
    func deleteFolk(completion: @escaping() -> Void) {
        self.realm.beginWrite()
        let folk = self.realm.objects(FolkModel.self)
        self.realm.delete(folk)
        try! self.realm.commitWrite()
        completion()
    }
    
    func deleteProverb(completion: @escaping() -> Void) {
        self.realm.beginWrite()
        let proverbModel = self.realm.objects(ProverbModel.self)
        self.realm.delete(proverbModel)
        try! self.realm.commitWrite()
        completion()
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
