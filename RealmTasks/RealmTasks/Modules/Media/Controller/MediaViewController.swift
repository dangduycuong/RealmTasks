//
//  MediaViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

class MediaViewController: BaseViewController {
    lazy var segmentedControl: SegmentedControlView = {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        let segmentedControl = SegmentedControlView(items: MediaType.list.map { $0.text }, frame: frame)
        return segmentedControl
    }()
    
    private var viewModel = MediaViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(MediaTableViewCell.self)
        tableView.register(with: PoemTableViewCell.self)
        viewModel.delegate = self
        viewModel.loadData()
        segmentedControl.selectedSegmentIndex = 0
        viewModel.mediaType = MediaType.list[segmentedControl.selectedSegmentIndex]
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: "Giải Trí")
        
        let allListMenuIcon = UIImageView(image: R.image.icons8Menu_rounded()?.withRenderingMode(.alwaysTemplate))
        allListMenuIcon.tintColor = UIColor.black
        let allMediaButton = UIButton()
        view.layout(allMediaButton)
            .centerY(titleLabel).right(16).width(44).height(44)
        
        allMediaButton.layout(allListMenuIcon)
            .right().centerY(allMediaButton).width(24).height(24)
        
        allMediaButton.addTarget(self, action: #selector(openAllMedia), for: .touchUpInside)
        
        view.layout(segmentedControl)
            .below(titleLabel, 32).left(16).right(16).height(40)
        
        view.layout(searchView)
            .below(segmentedControl, 16).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottomSafe().right()
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotifi(notification:)), name: .openAllMedia, object: nil)
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
        
        segmentedControl.indexValueChanged = { index in
            self.viewModel.mediaType = MediaType.list[index]
        }
    }
    
    @objc func receivedNotifi(notification: Notification) {
        let vc = MediaAllViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openAllMedia(_ sender: UIButton) {
        let vc = MediaAllViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
// MARK: - Navigation
extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.mediaType == .poem {
            return viewModel.poemsModel.count
        }
        return viewModel.filteredMediaTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.mediaType == .poem {
            let cell = tableView.dequeueReusableCell(cellType: PoemTableViewCell.self, forIndexPath: indexPath)
            let item = viewModel.poemsModel[indexPath.row]
            cell.configure(title: item.title ?? "", description: item.content ?? "", note: item.note, keyWord: viewModel.searchText)
            return cell
        }
        let cell = tableView.dequeueReusableCell(cellType: MediaTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(title: viewModel.filteredMediaTypeList[indexPath.row].title, searchText: viewModel.searchText)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.mediaType == .poem {
            return
        }
        let vc = MediaDetailViewController()
        let mediaType = viewModel.filteredMediaTypeList[indexPath.row]
        vc.mediaType = mediaType
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MediaViewController: MediaViewModelDelegate {
    func updateData() {
        tableView.reloadData()
    }
}
