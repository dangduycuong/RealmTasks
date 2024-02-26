//
//  MediaAllViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 29/04/2022.
//

import UIKit

class MediaAllViewController: BaseViewController {
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1", "2", "3", "4"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var searchView: NimsTinhChinhCapView = {
        let searchView: NimsTinhChinhCapView = NimsTinhChinhCapView.loadFromNib()
        searchView.backgroundColor = mainColor.withAlphaComponent(0.4)
        searchView.layer.cornerRadius = 8
        searchView.placeholderColor = mainColor
        return searchView
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
    
    var viewModel = MediaAllViewModel()
    let mainColor = UIColor.random
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCell(MediaDetailTableViewCell.self)
        
        viewModel.delegate = self
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
        
        showLoading()
        
        viewModel.loadData { [weak self] in
            self?.hideLoading()
            self?.tableView.reloadData()
        }
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: "Ca dao tục ngữ Việt Nam", color: mainColor)
        addBackButton(color: mainColor)
        
        view.layout(segmentedControl)
            .below(titleLabel, 32).left(16).right(16).height(40)
        
        for i in 0..<MediaAllViewSegmented.list.count {
            segmentedControl.setTitle(MediaAllViewSegmented.list[i].text, forSegmentAt: i)
        }
        if let bold = PlayfairDisplayFont.bold(with: 20) {
            let titleNormalAttributes = [
                NSAttributedString.Key.font: bold,
                NSAttributedString.Key.foregroundColor: mainColor.withAlphaComponent(0.4)
            ]
            let titleSelectedAttributes = [
                NSAttributedString.Key.font: bold,
                NSAttributedString.Key.foregroundColor: mainColor
            ]
            segmentedControl.setTitleTextAttributes(titleNormalAttributes, for: .normal)
            segmentedControl.setTitleTextAttributes(titleSelectedAttributes, for: .selected)
            segmentedControl.backgroundColor = mainColor.withAlphaComponent(0.4)
            segmentedControl.selectedSegmentTintColor = UIColor.white.withAlphaComponent(0.4)
        }
        segmentedControl.selectedSegmentIndex = 0
        
        view.layout(searchView)
            .below(segmentedControl, 16).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottom().right()
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        viewModel.displayType = MediaAllViewSegmented.list[segmentedControl.selectedSegmentIndex]
    }
    
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension MediaAllViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MediaDetailTableViewCell.self, forIndexPath: indexPath)
        cell.delegate = self
        cell.fillData(data: viewModel.filteredResultList[indexPath.row], searchText: viewModel.searchText, color: mainColor)
        
        return cell
    }
    
}

extension MediaAllViewController: MediaAllViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}

extension MediaAllViewController: MediaDetailTableViewCellDelegate {
    func favoriteChange(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        var data = viewModel.filteredResultList[indexPath.row]
        data.isFavorite = !data.isFavorite
        viewModel.modifyData(media: data)
    }
}
