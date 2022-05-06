//
//  MediaAllViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 29/04/2022.
//

import UIKit

enum MediaAllViewSegmented {
    case all
    case folkVerses
    case proverb
    case favorite
    
    static let list = [all, folkVerses, proverb, favorite]
    
    var text: String {
        get {
            switch self {
            case .all:
                return "All"
            case .folkVerses:
                return "Ca Dao"
            case .proverb:
                return "Tục Ngữ"
            case .favorite:
                return "Yêu Thích"
            }
        }
    }
}

class MediaAllViewController: BaseViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = MediaAllViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
    
    private func setupUI() {
        addBackButton()
        navigationItem.title = "Ca dao tục ngữ Việt Nam"
        for i in 0..<MediaAllViewSegmented.list.count {
            segmentedControl.setTitle(MediaAllViewSegmented.list[i].text, forSegmentAt: i)
        }
        if let bold = PlayfairDisplayFont.bold(with: 20) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = .black
            segmentedControl.selectedSegmentTintColor = .black
        }
    }
    
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
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
        cell.fillData(data: viewModel.filteredResultList[indexPath.row])
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
