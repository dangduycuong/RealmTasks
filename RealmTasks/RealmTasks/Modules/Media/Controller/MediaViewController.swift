//
//  MediaViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

enum MediaType {
    case folk
    case proverb
    
    static let list = [folk, proverb]
    
    var text: String {
        get {
            switch self {
            case .folk:
                return R.string.localizable.folk().language()
            case .proverb:
                return R.string.localizable.proverb().language()
            }
        }
    }
}

class MediaViewController: BaseViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel = MediaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableView.registerCell(MediaTableViewCell.self)
        viewModel.loadData()
        tableView.reloadData()
    }
    
    private func setupUI() {
        for i in 0..<MediaType.list.count {
            segmentedControl.setTitle(MediaType.list[i].text, forSegmentAt: i)
        }
        
        if let bold = MenloFont.bold(with: 16) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = .brown
            segmentedControl.selectedSegmentTintColor = AppColor.blueCustom
        }
    }
    
    
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
}
// MARK: - Navigation
extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaType.list[segmentedControl.selectedSegmentIndex] == .folk ? viewModel.listFolkType.count : viewModel.listProverbType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MediaTableViewCell.self, forIndexPath: indexPath)
        if MediaType.list[segmentedControl.selectedSegmentIndex] == .folk {
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
            
            if mediaType == .folk {
                vc.folkType = viewModel.listFolkType[indexPath.row]
            } else {
                vc.proverbType = viewModel.listProverbType[indexPath.row]
            }
            vc.mediaType = mediaType
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
