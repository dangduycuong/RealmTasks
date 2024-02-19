//
//  WisdomViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import UIKit

class WisdomViewController: BaseViewController {
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextDetail), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var searchView: NimsTinhChinhCapView = {
        let searchView: NimsTinhChinhCapView = NimsTinhChinhCapView.loadFromNib()
        searchView.backgroundColor = UIColor.random.withAlphaComponent(0.4)
        searchView.layer.cornerRadius = 8
        return searchView
    }()
    
    var viewModel = WisdomViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCell(WisdomTableViewCell.self)
        viewModel.delegate = self
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadData()
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: "Muu Tri")
        
        view.layout(searchView)
            .below(titleLabel, 32).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottom().right()
        
        view.layout(addButton)
            .bottomSafe(16).right(16).width(44).height(44)
        
        addButton.setTitle("", for: .normal)
        addButton.layer.cornerRadius = 22
        addButton.layer.shadowColor = UIColor.random.cgColor
        addButton.layer.shadowOpacity = 1
        addButton.layer.shadowOffset = .zero
        addButton.layer.shadowRadius = 8
        addButton.backgroundColor = UIColor.random
    }
    
    @IBAction func nextDetail(_ sender: UIButton) {
        let vc = WisdomDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WisdomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredListWisdom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: WisdomTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(content: viewModel.filteredListWisdom[indexPath.row].content, keyWord: viewModel.searchText)
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WisdomDetailViewController()
        vc.wisdom = viewModel.filteredListWisdom[indexPath.row]
        vc.isViewWisdomDetail = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeWisdomItem(wisdom: viewModel.filteredListWisdom[indexPath.row])
        }
    }
}

extension WisdomViewController: WisdomViewModelDelegate {
    func updateData() {
        tableView.reloadData()
    }
}
