//
//  TodoViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

class TodoViewController: BaseViewController {
    lazy var segmentedControl: SegmentedControlView = {
        let items = [
            R.string.localizable.all().language(),
            R.string.localizable.completed().language(),
            R.string.localizable.incompleted().language()
        ]
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let segmentedControl = SegmentedControlView(items: items, frame: frame)
        
        return segmentedControl
    }()
    
    private var viewModel = TodoViewModel()
    
    private var noData: Bool = false {
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
        tableView.delegate = self
        tableView.dataSource = self
        addObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getListDataFromRealm()
    }
    
    private func addObserver() {
        segmentedControl.indexValueChanged = { index in
            self.viewModel.segmentIndex = index
        }
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
    }
    
    private func prepareForViewController() {
        navigationController?.navigationBar.isHidden = true
        addBackground()
        
        addTitle(title: R.string.localizable.todo().language())
        
        view.layout(segmentedControl)
            .below(titleLabel, 32).left(16).right(16).height(40)
        
        view.layout(searchView)
            .below(segmentedControl, 16).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottom().right()
        
        setupAddDataButton()
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
        tabBarController?.tabBar.tintColor = UIColor.random
        tabBarController?.tabBar.unselectedItemTintColor = .gray
        
        if let bold = PlayfairDisplayFont.bold(with: 12) {
            let titleAttributes = [
                NSAttributedString.Key.font: bold,
                NSAttributedString.Key.foregroundColor: UIColor.gray
            ]
            
            let selectedAttributes = [
                NSAttributedString.Key.font: bold,
                NSAttributedString.Key.foregroundColor: UIColor.random
            ]
            
            UITabBarItem.appearance().setTitleTextAttributes(titleAttributes, for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        }
        
        // cach 2
        //        UITabBar.appearance().backgroundColor = .black
        //        tabBarController?.tabBar.backgroundImage = UIImage()   //Clear background
        //
        //        //Set the item tint colors
        //        tabBarController?.tabBar.tintColor = UIColor.random
        //        tabBarController?.tabBar.unselectedItemTintColor = .lightGray
    }
    
    // MARK: - Actions
    override func nextDetail(_ sender: UIButton) {
        let vc = TodoInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
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
        cell.fillData(todo: viewModel.filterTodos[indexPath.row], searchText: viewModel.searchText)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TodoInfoViewController()
        vc.todo = viewModel.filterTodos[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
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
            NSAttributedString.Key.foregroundColor: UIColor.random.withAlphaComponent(0.4),
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
        containerView.backgroundColor = UIColor.random
        containerView.layer.shadowColor = UIColor.random.cgColor
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
        searchTextField.textColor = UIColor.random
        searchTextField.tintColor = UIColor.random
    }
    
    // Override draw method if you want to perform custom drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Custom drawing code here if needed
    }
}
