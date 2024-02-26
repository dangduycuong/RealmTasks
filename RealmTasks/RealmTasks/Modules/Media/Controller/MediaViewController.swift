//
//  MediaViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

class MediaViewController: BaseViewController {
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: MediaType.list.map { $0.text })
        segmentedControl.addTarget(self, action: #selector(segmentedControlClicked), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var searchView: NimsTinhChinhCapView = {
        let searchView: NimsTinhChinhCapView = NimsTinhChinhCapView.loadFromNib()
        searchView.backgroundColor = mainColor.withAlphaComponent(0.4)
        searchView.layer.cornerRadius = 8
        searchView.placeholderColor = mainColor
        return searchView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        
        return tableView
    }()
    
    var viewModel = MediaViewModel()
    let mainColor = UIColor.random
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
        
        tableView.registerCell(MediaTableViewCell.self)
        tableView.register(with: PoemTableViewCell.self)
        viewModel.delegate = self
        viewModel.loadData()
        segmentedControl.selectedSegmentIndex = 0
        viewModel.mediaType = MediaType.list[segmentedControl.selectedSegmentIndex]
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: "Giải Trí", color: mainColor)
        
        let allListMenuIcon = UIImageView(image: R.image.icons8Menu_rounded()?.withRenderingMode(.alwaysTemplate))
        allListMenuIcon.tintColor = mainColor
        let allMediaButton = UIButton()
        view.layout(allMediaButton)
            .centerY(titleLabel).right(16).width(44).height(44)
        
        allMediaButton.layout(allListMenuIcon)
            .right().centerY(allMediaButton).width(24).height(24)
        
        allMediaButton.addTarget(self, action: #selector(openAllMedia), for: .touchUpInside)
        
        view.layout(segmentedControl)
            .below(titleLabel, 32).left(16).right(16).height(40)
        
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
        
        view.layout(searchView)
            .below(segmentedControl, 16).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottom().right()
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotifi(notification:)), name: .openAllMedia, object: nil)
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
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
    
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        viewModel.mediaType = MediaType.list[segmentedControl.selectedSegmentIndex]
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
            cell.configure(title: item.title ?? "", description: item.content ?? "", note: item.note, keyWord: viewModel.searchText,  color: mainColor)
            return cell
        }
        let cell = tableView.dequeueReusableCell(cellType: MediaTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(title: viewModel.filteredMediaTypeList[indexPath.row].title, searchText: viewModel.searchText, colorCell: mainColor)
        
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
