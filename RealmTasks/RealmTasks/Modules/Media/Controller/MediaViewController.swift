//
//  MediaViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

enum MediaType {
    case folkVerses
    case proverb
    
    static let list = [folkVerses, proverb]
    
    var text: String {
        get {
            switch self {
            case .folkVerses:
                return R.string.localizable.folk_verses().language()
            case .proverb:
                return R.string.localizable.proverb().language()
            }
        }
    }
}

class MediaViewController: BaseViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel = MediaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableView.registerCell(MediaTableViewCell.self)
        viewModel.delegate = self
        viewModel.loadData()
        tableView.reloadData()
        
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
    }
    
    private func setupUI() {
        for i in 0..<MediaType.list.count {
            segmentedControl.setTitle(MediaType.list[i].text, forSegmentAt: i)
        }
        
        if let bold = MenloFont.bold(with: 16) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = .black
            segmentedControl.selectedSegmentTintColor = .black
        }
    }
    
    
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        viewModel.mediaType = MediaType.list[segmentedControl.selectedSegmentIndex]
    }
    
}
// MARK: - Navigation
extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaType.list[segmentedControl.selectedSegmentIndex] == .folkVerses ? viewModel.filteredFolkType.count : viewModel.filteredProverbType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MediaTableViewCell.self, forIndexPath: indexPath)
        if MediaType.list[segmentedControl.selectedSegmentIndex] == .folkVerses {
            cell.fillData(title: viewModel.listFolkType[indexPath.row].title)
        } else {
            cell.fillData(title: viewModel.listProverbType[indexPath.row].title)
        }
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = R.storyboard.media.mediaDetailViewController() {
            let mediaType = MediaType.list[segmentedControl.selectedSegmentIndex]
            
            if mediaType == .folkVerses {
                vc.folkType = viewModel.filteredFolkType[indexPath.row]
            } else {
                vc.proverbType = viewModel.filteredProverbType[indexPath.row]
            }
            vc.mediaType = mediaType
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension MediaViewController: MediaViewModelDelegate {
    func updateData() {
        tableView.reloadData()
    }
}
