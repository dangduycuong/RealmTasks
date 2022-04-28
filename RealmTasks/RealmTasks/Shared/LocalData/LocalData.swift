//
//  LocalData.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//
import Foundation

enum LocalKey: String {
    case currentLanguage = "currentLanguage"
}

class LocalData {
    class func saveToLocal(value: String, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    class func getDataFromLocal(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    class func removeDataLocal(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
