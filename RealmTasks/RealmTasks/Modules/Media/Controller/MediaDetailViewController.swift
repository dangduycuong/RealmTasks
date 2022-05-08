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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = MediaDetailViewModel()
    var mediaType = MediaTypeLocalModel()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func setupUI() {
        title = mediaType.title
        addBackButton()
        
        for i in 0..<MediaDetailSegmentedControl.list.count {
            segmentedControl.setTitle(MediaDetailSegmentedControl.list[i].text, forSegmentAt: i)
        }
        
        if let bold = PlayfairDisplayFont.bold(with: 20) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = .black
            segmentedControl.selectedSegmentTintColor = .black
        }
        addRightBarButtonItems()
    }
    
    private func addRightBarButtonItems() {
        let image = R.image.icons8Menu_rounded()?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        imageView.tintColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(saveClicked(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        let rightBarButtonItem = UIBarButtonItem(customView: imageView)
        navigationItem.rightBarButtonItems = [rightBarButtonItem]
    }
    
    // MARK: - Action
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        viewModel.valueChange = MediaDetailSegmentedControl.list[segmentedControl.selectedSegmentIndex]
        tableView.reloadData()
    }
    
    @objc func saveClicked(tapGestureRecognizer: UITapGestureRecognizer) {
        if let vc = R.storyboard.media.detailListVC() {
            vc.mediaType = mediaType
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension MediaDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MediaDetailTableViewCell.self, forIndexPath: indexPath)
        cell.delegate = self
        cell.fillData(data: viewModel.filteredList[indexPath.row])
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
