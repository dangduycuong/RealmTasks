//
//  TodoViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import Foundation
import RealmSwift

class TodoViewModel {
    
    var listTodo = [TodoModel]()
    var filterTodos = [TodoModel]()
    
    func addDataToRealm(_ todo: TodoModel) {
        
    }
    
    func modifyDataRealm(dataEdit: TodoModel) {
        
    }
    
    func removeDocumentOffline(id: String) -> Bool {
        
        return true
    }
    
    func getListDataFromRealm(_ completionHandler: @escaping () -> Void ) {
        DataManager.shared.getListDataFromRealm({ [weak self] todos in
            guard let `self` = self else { return }
            self.listTodo = todos
            self.filterTodos = todos
            completionHandler()
        })
    }
}
