//
//  TodoInfoViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import Foundation

enum TodoTask {
    case add
    case modify
    case error
}

protocol SaveTodoInfoDelegate: AnyObject {
    func savedTodo(message: String, type: TodoTask)
}

class TodoInfoViewModel {
    var id = UUID().uuidString
    var todoCompleted: Bool = false
    weak var delegate: SaveTodoInfoDelegate?
    
    func setupData(todo: TodoModel) {
        todoCompleted = todo.isCompleted
        id = todo.id
    }
    
    func addDataToRealm(todoTitle: String, todoDescription: String) {
        if checkConditionTodo(todoTitle: todoTitle, todoDescription: todoDescription) {
            let todo = TodoModel()
            id = UUID().uuidString
            todo.id = id
            todo.todoTitle = todoTitle
            todo.todoDescription = todoDescription
            todo.isCompleted = todoCompleted
            DataManager.shared.addDataToRealm(todo)
            delegate?.savedTodo(message: "Add new todo success", type: .add)
        } else {
            delegate?.savedTodo(message: "Nhap du thong tin", type: .error)
        }
    }
    
    func modifyDataRealm(todoTitle: String, todoDescription: String) {
        if checkConditionTodo(todoTitle: todoTitle, todoDescription: todoDescription) {
            let todo = TodoModel()
            todo.id = id
            todo.todoTitle = todoTitle
            todo.todoDescription = todoDescription
            todo.isCompleted = todoCompleted
            DataManager.shared.modifyDataRealm(dataEdit: todo)
            delegate?.savedTodo(message: "Modify to do success", type: .modify)
        } else {
            delegate?.savedTodo(message: "Nhap du thong tin", type: .error)
        }
    }
    
    func removeDocumentOffline(id: String) -> Bool {
        return true
    }
    
    private func checkConditionTodo(todoTitle: String, todoDescription: String) -> Bool {
        if todoTitle == "" || todoDescription == "" {
            return false
        }
        return true
    }
}
