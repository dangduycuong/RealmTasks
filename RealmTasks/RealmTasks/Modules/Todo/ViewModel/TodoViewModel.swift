//
//  TodoViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import Foundation
import RealmSwift

protocol UpdateTodoData: AnyObject {
    func updateData()
}

enum TodoType {
    case all
    case completed
    case incompleted
    
    static let list = [all, completed, incompleted]
    
    var text: String {
        get {
            switch self {
            case .all:
                return "All"
            case .completed:
                return "Completed"
            case .incompleted:
                return "Incompleted"
            }
        }
    }
}

class TodoViewModel {
    
    var listTodo = [TodoModel]()
    
    var filterTodos = [TodoModel]()
    
    var searchText: String = "" {
        didSet(oldName) {
            print("Name changed from \(oldName) to \(searchText)")
            filterData()
        }
    }
    
    var segmentIndex: Int = 0 {
        didSet(oldValue) {
            print("changed from \(oldValue) to \(segmentIndex)")
            filterData()
        }
    }
    
    weak var delegate: UpdateTodoData?
    
    func modifyDataRealm(indexPath: IndexPath) {
        let todo = filterTodos[indexPath.row]
        let todoUpdate = TodoModel()
        todoUpdate.id = todo.id
        todoUpdate.todoTitle = todo.todoTitle
        todoUpdate.todoDescription = todo.todoDescription
        todoUpdate.isCompleted = !todo.isCompleted
        DataManager.shared.modifyDataRealm(dataEdit: todoUpdate)
        getListDataFromRealm()
    }
    
    func removeTodo(todo: TodoModel) {
        if DataManager.shared.removeDocumentOffline(id: todo.id) {
            getListDataFromRealm()
        }
    }
    
    func getListDataFromRealm() {
        DataManager.shared.getListDataFromRealm({ [weak self] todos in
            guard let `self` = self else { return }
            self.listTodo = todos
            self.filterData()
        })
    }
    
    private func filterData() {
        let type = TodoType.list[segmentIndex]
        var list = [TodoModel]()
        
        switch type {
        case .all:
            list = listTodo
        case .completed:
            list = listTodo.filter({ todo in
                return todo.isCompleted == true
            })
        case .incompleted:
            list = listTodo.filter({ todo in
                return todo.isCompleted == false
            })
        }
        
        if searchText == "" {
            filterTodos = list
        } else {
            filterTodos = list.filter { (todo: TodoModel) in
                let title = todo.todoTitle.lowercased().unaccent()
                let description = todo.todoDescription.lowercased().unaccent()
                
                let keyText = searchText.lowercased().unaccent()
                if title.range(of: keyText) != nil || description.range(of: keyText) != nil {
                    
                    return true
                }
                return false
            }
        }
        delegate?.updateData()
    }
}
