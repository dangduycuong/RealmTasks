//
//  MediaAllViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 29/04/2022.
//

import UIKit

class MediaAllViewController: BaseViewController {
    private lazy var segmentedView: SegmentedControlView = {
        let items = MediaAllViewSegmented.list.map { $0.text }
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let segmentedView = SegmentedControlView(items: items, frame: frame)
        return segmentedView
    }()
    
    private var viewModel = MediaAllViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
        tableView.registerCell(MediaDetailTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        showLoading()
    }
    
    private func addObserver() {
        segmentedView.indexValueChanged = { [weak self] index in
            guard let `self` = self else { return }
            self.viewModel.displayType = MediaAllViewSegmented.list[index]
        }
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
        viewModel.loadData { [weak self] in
            guard let `self` = self else { return }
            self.hideLoading()
            self.tableView.reloadData()
        }
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: "Ca dao tục ngữ Việt Nam")
        addBackButton()
        
        view.layout(segmentedView)
            .below(titleLabel, 32).left(16).right(16).height(40)
        
        view.layout(searchView)
            .below(segmentedView, 16).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottom().right()
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
        cell.fillData(data: viewModel.filteredResultList[indexPath.row], searchText: viewModel.searchText)
        
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
