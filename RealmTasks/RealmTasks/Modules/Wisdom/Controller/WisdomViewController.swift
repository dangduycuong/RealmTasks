//
//  WisdomViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import UIKit

class WisdomViewController: BaseViewController {
    private  var viewModel = WisdomViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
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
        addTitle(title: "Mưu Trí")
        
        view.layout(searchView)
            .below(titleLabel, 32).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottomSafe().right()
        
        setupAddDataButton()
    }
    
    override func nextDetail(_ sender: UIButton) {
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
        
        cell.selectionStyle = .none
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
