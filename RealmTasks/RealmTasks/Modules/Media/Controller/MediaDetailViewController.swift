//
//  MediaDetailViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import UIKit

enum MediaDetailSegmentedControl {
    case all
    case favorite
    
    static let list = [all, favorite]
    
    var text: String {
        get {
            switch self {
            case .all:
                return R.string.localizable.all().language()
            case .favorite:
                return R.string.localizable.favorite().language()
            }
        }
    }
}

class MediaDetailViewController: BaseViewController {
    private lazy var segmentedView: SegmentedControlView = {
        let items: [String] = MediaDetailSegmentedControl.list.map { $0.text }
        let segmentedView = SegmentedControlView(items: items, frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return segmentedView
    }()
    
    var viewModel = MediaDetailViewModel()
    var mediaType = MediaTypeLocalModel()
    
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
        viewModel.loadData(mediaType: mediaType)
        tableView.reloadData()
    }
    
    func addObserver() {
        segmentedView.indexValueChanged = { [weak self] index in
            guard let `self` = self else { return }
            self.viewModel.valueChange = MediaDetailSegmentedControl.list[index]
            self.tableView.reloadData()
        }
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: mediaType.title)
        addBackButton()
        
        view.layout(segmentedView)
            .below(titleLabel, 32).left(16).right(16).height(40)
        
        view.layout(searchView)
            .below(segmentedView, 16).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottom().right()
        addRightBarButtonItems()
    }
    
    private func addRightBarButtonItems() {
        let image = R.image.icons8Menu_rounded()?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor.black
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(saveClicked(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        view.layout(imageView)
            .centerY(titleLabel).right(16).width(24).height(24)
    }
    
    // MARK: - Action
    @objc func saveClicked(tapGestureRecognizer: UITapGestureRecognizer) {
        let vc = DetailListVC()
        vc.mediaType = mediaType
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MediaDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MediaDetailTableViewCell.self, forIndexPath: indexPath)
        cell.delegate = self
        cell.fillData(data: viewModel.filteredList[indexPath.row], searchText: viewModel.searchText)
        
        return cell
    }
}

extension MediaDetailViewController: MediaDetailViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}

extension MediaDetailViewController: MediaDetailTableViewCellDelegate {
    func favoriteChange(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        var data = viewModel.filteredList[indexPath.row]
        data.isFavorite = !data.isFavorite
        viewModel.modifyData(media: data)
    }
}
