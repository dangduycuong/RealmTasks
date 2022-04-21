//
//  TodoInfoViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import Foundation

class TodoInfoViewModel {
    var todo = TodoModel()
    var todoCompleted: Bool = false
    
    func setupData(data: TodoModel) {
        todo = data
        todoCompleted = data.isCompleted
    }
    
    func addDataToRealm(todoTitle: String, todoDescription: String) {
        todo.id = UUID().uuidString
        todo.todoTitle = todoTitle
        todo.todoDescription = todoDescription
        
        DataManager.shared.addDataToRealm(todo)
    }
    
    func modifyDataRealm(todoTitle: String, todoDescription: String) {
        let new = TodoModel()
        new.id = todo.id
        new.todoTitle = todoTitle
        new.todoDescription = todoDescription
        new.isCompleted = todoCompleted
        DataManager.shared.modifyDataRealm(dataEdit: new)
    }
    
    func removeDocumentOffline(id: String) -> Bool {
        
        return true
    }
}
