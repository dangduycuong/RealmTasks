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
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1", "2"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var searchView: NimsTinhChinhCapView = {
        let view: NimsTinhChinhCapView = NimsTinhChinhCapView.loadFromNib()
        view.backgroundColor = UIColor.random.withAlphaComponent(0.4)
        view.layer.cornerRadius = 8
        return view
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
    
    var viewModel = MediaDetailViewModel()
    var mediaType = MediaTypeLocalModel()
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCell(MediaDetailTableViewCell.self)
        viewModel.delegate = self
        viewModel.loadData(mediaType: mediaType)
        tableView.reloadData()
        
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: mediaType.title)
        addBackButton()
        
        view.layout(segmentedControl)
            .below(titleLabel, 32).left(16).right(16).height(40)
        
        for i in 0..<MediaDetailSegmentedControl.list.count {
            segmentedControl.setTitle(MediaDetailSegmentedControl.list[i].text, forSegmentAt: i)
        }
        
        if let bold = PlayfairDisplayFont.bold(with: 20) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.random]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = UIColor.random
            segmentedControl.selectedSegmentTintColor = UIColor.random.withAlphaComponent(0.4)
        }
        
        view.layout(searchView)
            .below(segmentedControl, 16).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottom().right()
        addRightBarButtonItems()
    }
    
    private func addRightBarButtonItems() {
        let image = R.image.icons8Menu_rounded()?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        
        
        imageView.tintColor = UIColor.random
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(saveClicked(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        view.layout(imageView)
            .centerY(titleLabel).right(16).width(24).height(24)
    }
    
    // MARK: - Action
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        viewModel.valueChange = MediaDetailSegmentedControl.list[segmentedControl.selectedSegmentIndex]
        tableView.reloadData()
    }
    
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
        cell.fillData(data: viewModel.filteredList[indexPath.row], keyWord: viewModel.searchText)
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = selectedBackgroundView
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
