//
//  TodoViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

class TodoViewController: BaseViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTodoButton: UIButton!
    
    var viewModel = TodoViewModel()
    
    var noData: Bool = false {
        didSet {
            searchView.isHidden = noData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        viewModel.delegate = self
        tableView.registerCell(TodoTableViewCell.self)
        
        
        if let language = LocalData.getDataFromLocal(key: LocalKey.currentLanguage.rawValue) {
            LocalizationHandlerUtil.shareInstance().setLanguageIdentifier(language)
        }
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getListDataFromRealm()
    }
    
    private func setupTabbar() {
        tabBarController?.title = "todo".language()
        //Set the background color
        // cach 1
        let backroundImageView = UIImageView(image: UIImage(named: "cool-background"))
        if let frame = tabBarController?.tabBar.bounds {
            backroundImageView.frame = frame
        }
        
        tabBarController?.tabBar.layout(backroundImageView)
            .top().left().bottom().right()
        tabBarController?.tabBar.sendSubviewToBack(backroundImageView)
        tabBarController?.tabBar.tintColor = .white
        tabBarController?.tabBar.unselectedItemTintColor = .gray
        
        if let bold = MenloFont.bold(with: 12) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.gray]
            let selectedAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            
            UITabBarItem.appearance().setTitleTextAttributes(titleAttributes, for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        }
        
        // cach 2
//        UITabBar.appearance().backgroundColor = .black
//        tabBarController?.tabBar.backgroundImage = UIImage()   //Clear background
//
//        //Set the item tint colors
//        tabBarController?.tabBar.tintColor = .white
//        tabBarController?.tabBar.unselectedItemTintColor = .lightGray
    }
    
    private func setupUI() {
        removeBorderNavigationBar()
        addTodoButton.tintColor = .white
        addTodoButton.setTitle("", for: .normal)
        addTodoButton.layer.shadowColor = UIColor.white.cgColor
        addTodoButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addTodoButton.layer.shadowRadius = 5
        addTodoButton.layer.shadowOpacity = 1.0
        addTodoButton.layer.cornerRadius = 20
        
        segmentedControl.setTitle(R.string.localizable.all().language(), forSegmentAt: 0)
        segmentedControl.setTitle(R.string.localizable.completed().language(), forSegmentAt: 1)
        segmentedControl.setTitle(R.string.localizable.incompleted().language(), forSegmentAt: 2)
        
        if let bold = MenloFont.bold(with: 16) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = .black
            segmentedControl.selectedSegmentTintColor = .black
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
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
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

extension TodoViewController: UpdateTodoData {
    func updateData() {
        tableView.reloadData()
        noData = viewModel.filterTodos.isEmpty
    }
}

extension TodoViewController: TodoTableViewCellDelegate {
    func modifyTodoStatus(indexPath: IndexPath) {
        viewModel.modifyDataRealm(indexPath: indexPath)
    }
}
