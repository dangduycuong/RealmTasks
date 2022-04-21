//
//  TodoViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

class TodoViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableView.registerCell(TodoTableViewCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getListDataFromRealm({ [weak self] in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        })
    }
    
    private func setupUI() {
        removeBorderNavigationBar()
        tabBarController?.tabBar.tintColor = AppColor.blueCustom
        tabBarController?.title = "Todo"
    }
    
    @IBAction func addTodoButtonClicked(_ sender: Any) {
        if let vc = R.storyboard.todo.todoInfoViewController() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: TodoTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(todo: viewModel.filterTodos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = R.storyboard.todo.todoInfoViewController() {
            vc.todo = viewModel.filterTodos[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
