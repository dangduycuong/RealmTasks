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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var folkType = FolkTypeModel()
    var viewModel = MediaDetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ca dao"
        tableView.registerCell(MediaDetailTableViewCell.self)
        viewModel.delegate = self
        viewModel.folkType = folkType
        viewModel.loadFile()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func setupUI() {
        addBackButton()
        
        for i in 0..<MediaDetailSegmentedControl.list.count {
            segmentedControl.setTitle(MediaDetailSegmentedControl.list[i].text, forSegmentAt: i)
        }
        
        if let bold = MenloFont.bold(with: 16) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = .brown
            segmentedControl.selectedSegmentTintColor = AppColor.blueCustom
        }
    }
    
    // MARK: - Action
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
    }
    
}

extension MediaDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MediaDetailTableViewCell.self, forIndexPath: indexPath)
        cell.delegate = self
        cell.fillData(text: viewModel.filterList[indexPath.row])
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .white
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }
}

extension MediaDetailViewController: MediaDetailViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}

extension MediaDetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}

extension MediaDetailViewController: MediaDetailTableViewCellDelegate {
    func favoriteChange(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        print(viewModel.filterList[indexPath.row])
        let type = MediaDetailSegmentedControl.list[segmentedControl.selectedSegmentIndex]
        if type == .all {
            
        } else {
//            viewModel.removeFolk(folk: )
        }
    }
}
