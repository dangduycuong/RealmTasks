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
    
    //MARK: - TodoModel
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
    
    //MARK: - MediaTypeLocalModel
    func addMediaTypeToRealm(_ data: MediaTypeLocalModel) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getListMediaType(_ completionHandler: @escaping ([MediaTypeLocalModel]) -> Void ) {
        var listData = [MediaTypeLocalModel]()
        let todo = realm.objects(MediaTypeLocalModel.self)
        for item in todo {
            listData.append(item)
        }
        completionHandler(listData)
    }
    
    func removeMediaType(id: String) -> Bool {
        guard let todo = realm.objects(MediaTypeLocalModel.self).filter({$0.id == id}).first else { return false }
        try! realm.write {
            realm.delete(todo)
        }
        return true
    }
    
    func deleteMediaType(completion: @escaping () -> Void) {
        self.realm.beginWrite()
        let mediaType = self.realm.objects(MediaTypeLocalModel.self)
        self.realm.delete(mediaType)
        try! self.realm.commitWrite()
        completion()
    }
    //MARK: - Media Model
    func addMediaToRealm(_ data: MediaDetailLocalModel) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func modifyMedia(dataEdit: MediaDetailLocalModel) {
        let listData = realm.objects(MediaDetailLocalModel.self)
        realm.beginWrite()
        
        if let i = listData.firstIndex(where: { $0.id == dataEdit.id }) {
            listData[i].fileName = dataEdit.fileName
            listData[i].title = dataEdit.title
            listData[i].content = dataEdit.content
            listData[i].isFavorite = dataEdit.isFavorite
            listData[i].mediaType = dataEdit.mediaType
        }
        
        try! realm.commitWrite()
    }
    
    func getListMedia(_ completionHandler: @escaping ([MediaDetailLocalModel]) -> Void ) {
        var listData = [MediaDetailLocalModel]()
        let todo = realm.objects(MediaDetailLocalModel.self)
        for item in todo {
            listData.append(item)
        }
        completionHandler(listData)
    }
    
    func removeMedia(id: String) -> Bool {
        guard let folk = realm.objects(MediaDetailLocalModel.self).filter({$0.id == id}).first else { return false }
        try! realm.write {
            realm.delete(folk)
        }
        return true
    }
    
    func deleteMedia(completion: @escaping () -> Void) {
        self.realm.beginWrite()
        let mediaDetail = self.realm.objects(MediaDetailLocalModel.self)
        self.realm.delete(mediaDetail)
        try! self.realm.commitWrite()
        completion()
    }
    
    //MARK: - TodoModel
    func addWisdomToRealm(_ wisdom: WisdomModel) {
        try! realm.write {
            realm.add(wisdom)
        }
    }
    
    func modifyWisdom(dataEdit: WisdomModel) {
        let listData = realm.objects(WisdomModel.self)
        realm.beginWrite()
        for item in listData {
            if item.id == dataEdit.id {
                item.content = dataEdit.content
            }
        }
        try! realm.commitWrite()
    }
    
    func getListWisdomFromRealm(_ completionHandler: @escaping ([WisdomModel]) -> Void ) {
        var listData = [WisdomModel]()
        let wisdoms = realm.objects(WisdomModel.self)
        for item in wisdoms {
            listData.append(item)
        }
        completionHandler(listData)
    }
    
    func removeWisdomItem(id: String) -> Bool {
        guard let wisdom = realm.objects(WisdomModel.self).filter({$0.id == id}).first else { return false }
        try! realm.write {
            realm.delete(wisdom)
        }
        return true
    }
    
    //MARK: - DiaryModel
    func addDiaryToRealm(_ diary: DiaryModel) {
        try! realm.write {
            realm.add(diary)
        }
    }
    
    func modifyDiary(dataEdit: DiaryModel) {
        let listData = realm.objects(DiaryModel.self)
        realm.beginWrite()
        for item in listData {
            if item.id == dataEdit.id {
                item.content = dataEdit.content
                item.upDateTime = dataEdit.upDateTime
            }
        }
        try! realm.commitWrite()
    }
    
    func removeDiaryItem(id: String) -> Bool {
        guard let wisdom = realm.objects(DiaryModel.self).filter({$0.id == id}).first else { return false }
        try! realm.write {
            realm.delete(wisdom)
        }
        return true
    }
    
    func getListDiaryFromRealm(_ completionHandler: @escaping ([DiaryModel]) -> Void ) {
        var listData = [DiaryModel]()
        let items = realm.objects(DiaryModel.self)
        for item in items {
            listData.append(item)
        }
        completionHandler(listData)
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
