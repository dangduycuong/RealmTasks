//
//  TodoViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

class TodoViewController: BaseViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTodoButton: UIButton!
    @IBOutlet var noDataImageView: UIImageView!
    
    var noData: Bool = true {
        didSet {
            noData ? (tableView.tableHeaderView = noDataImageView) : (tableView.tableHeaderView = nil)
        }
    }
    
    var viewModel = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.delegate = self
        tableView.registerCell(TodoTableViewCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getListDataFromRealm()
    }
    
    private func setupUI() {
        removeBorderNavigationBar()
        tabBarController?.tabBar.tintColor = AppColor.blueCustom
        tabBarController?.title = "Todo"
        addTodoButton.tintColor = AppColor.blueCustom
        addTodoButton.setTitle("", for: .normal)
        addTodoButton.layer.shadowColor = AppColor.blueCustom.cgColor
        addTodoButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addTodoButton.layer.shadowRadius = 5
        addTodoButton.layer.shadowOpacity = 1.0
        addTodoButton.layer.cornerRadius = 20
        
        if let bold = MenloFont.bold(with: 16) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = .brown
            segmentedControl.selectedSegmentTintColor = AppColor.blueCustom
        }
        
    }
    
    @IBAction func segmentControlValueChanged(_ sender: Any) {
        viewModel.segmentIndex = segmentedControl.selectedSegmentIndex
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
        cell.indexPath = indexPath
        cell.delegate = self
        cell.fillData(todo: viewModel.filterTodos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = R.storyboard.todo.todoInfoViewController() {
            vc.todo = viewModel.filterTodos[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeTodo(todo: viewModel.filterTodos[indexPath.row])
        }
    }
}

extension TodoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}

extension TodoViewController: UpdateTodoData {
    func updateData() {
        noData = viewModel.filterTodos.isEmpty
        tableView.reloadData()
    }
}

extension TodoViewController: TodoTableViewCellDelegate {
    func modifyTodoStatus(indexPath: IndexPath) {
        viewModel.modifyDataRealm(indexPath: indexPath)
    }
}
