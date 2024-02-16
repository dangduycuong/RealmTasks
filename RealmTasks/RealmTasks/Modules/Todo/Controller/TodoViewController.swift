//
//  TodoViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

class TodoViewController: BaseViewController {
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["First","Second","Third"])
        return segmentedControl
    }()
    
    private lazy var searchView: CustomView = {
        //        let searchView: SearchView = SearchView.loadFromNib()
        let searchView = CustomView()
        return searchView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var addTodoButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    var viewModel = TodoViewModel()
    
    var noData: Bool = false {
        didSet {
            searchView.isHidden = noData
        }
    }
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        viewModel.delegate = self
        tableView.registerCell(TodoTableViewCell.self)
        
//        searchView.searchText = { [weak self] text in
//            guard let `self` = self else { return }
//            self.viewModel.searchText = text
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getListDataFromRealm()
    }
    
    private func prepareForViewController() {
        navigationController?.navigationBar.isHidden = true
        let imageView = UIImageView(image: UIImage(named: "woodGrain3"))
        view.layout(imageView)
            .top().left().bottom().right()
        
        addTitle(title: R.string.localizable.todo().language())
        
        view.layout(segmentedControl)
            .below(titleLabel, 16).left(16).right(16).height(40)
        
        segmentedControl.setTitle(R.string.localizable.all().language(), forSegmentAt: 0)
        segmentedControl.setTitle(R.string.localizable.completed().language(), forSegmentAt: 1)
        segmentedControl.setTitle(R.string.localizable.incompleted().language(), forSegmentAt: 2)
        
        if let bold = PlayfairDisplayFont.bold(with: 20) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = .black
            segmentedControl.selectedSegmentTintColor = UIColor.white.withAlphaComponent(0.4)
        }
        
        view.layout(searchView)
            .below(segmentedControl, 16).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottom().right()
        
        view.layout(addTodoButton)
            .right(32).bottomSafe(32).width(44).height(44)
        
        let buttonIcon = UIImage(named: "canhBuom")
        view.layout(UIImageView(image: buttonIcon))
            .center(addTodoButton).width(24).height(24)
        
        addTodoButton.addTarget(self, action: #selector(addTodoButtonClicked), for: .touchUpInside)
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
        
        if let bold = PlayfairDisplayFont.bold(with: 12) {
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
        addTodoButton.tintColor = .white
        addTodoButton.setTitle("", for: .normal)
        addTodoButton.layer.shadowColor = UIColor.white.cgColor
        addTodoButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addTodoButton.layer.shadowRadius = 5
        addTodoButton.layer.shadowOpacity = 1.0
        addTodoButton.layer.cornerRadius = 20
    }
    
    @IBAction func segmentControlValueChanged(_ sender: Any) {
        viewModel.segmentIndex = segmentedControl.selectedSegmentIndex
    }
    
    @IBAction func addTodoButtonClicked(_ sender: UIButton) {
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

extension TodoViewController: UpdateTodoData {
    func updateData() {
        tableView.reloadData()
        noData = viewModel.listTodo.isEmpty
    }
}

extension TodoViewController: TodoTableViewCellDelegate {
    func modifyTodoStatus(indexPath: IndexPath) {
        viewModel.modifyDataRealm(indexPath: indexPath)
    }
}

import UIKit

class CustomView: UIView {
    
    lazy var containerView: UIView = {
       let view = UIView()
        return view
    }()
    
    lazy var searchImageView: UIImageView = {
        let view = UIImageView(image: R.image.icons8Search())
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.lineHeightMultiple = 1.0
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "PlayfairDisplay-Italic", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4),
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        let attributedPlaceholder = NSAttributedString(string: "Nhập tên bài thơ", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        return textField
    }()
    // Custom properties or variables
    
    // This initializer is called when creating the view programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Custom initialization code
        setupView()
    }
    
    // This initializer is called when creating the view from Interface Builder (Storyboard or XIB)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Custom initialization code
        setupView()
    }
    
    private func setupView() {
        containerView.removeFromSuperview()
        searchImageView.removeFromSuperview()
        searchImageView.removeFromSuperview()
        
        self.layout(containerView)
            .top().left().bottom().right()
        containerView.backgroundColor = .black
        containerView.layer.shadowColor = UIColor.white.cgColor
        containerView.layer.shadowOpacity = 0.35
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 2
        containerView.layer.cornerRadius = 16
        
        containerView.layout(searchImageView)
            .left(8).centerY().width(24).height(24)
        
        containerView.layout(searchTextField)
            .top(4)
            .after(searchImageView, 4)
            .bottom(4).right(4)
        searchTextField.font = R.font.playfairDisplayMedium(size: 20)
        searchTextField.textColor = UIColor.white
        searchTextField.tintColor = UIColor.white
    }
    
    // Override draw method if you want to perform custom drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Custom drawing code here if needed
    }
}
