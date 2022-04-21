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

class TodoViewModel {
    
    var listTodo = [TodoModel]()
    
    var filterTodos = [TodoModel]()
    
    var searchText: String = "" {
        didSet(oldName) {
            print("Name changed from \(oldName) to \(searchText)")
            filterData()
        }
    }
    
    weak var delegate: UpdateTodoData?
    
    func modifyDataRealm(dataEdit: TodoModel) {
        DataManager.shared.modifyDataRealm(dataEdit: dataEdit)
    }
    
    func removeTodo(todo: TodoModel, completed: @escaping(() -> Void)) {
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
        if searchText == "" {
            filterTodos = listTodo
        } else {
            filterTodos = listTodo.filter { (todo: TodoModel) in
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
