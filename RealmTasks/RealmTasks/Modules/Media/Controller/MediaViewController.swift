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
                return "R.string.localizable."
            case .proverb:
                return "8989"
            }
        }
    }
}

class MediaViewController: BaseViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel = MediaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCell(MediaTableViewCell.self)
    }
    
    
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
    }
    
}
// MARK: - Navigation
extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaType.list[segmentControl.selectedSegmentIndex] == .folk ? viewModel.listFolkType.count : viewModel.listProverbType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MediaTableViewCell.self, forIndexPath: indexPath)
        if MediaType.list[segmentControl.selectedSegmentIndex] == .folk {
            cell.fillData(title: viewModel.listFolkType[indexPath.row].title)
        } else {
            cell.fillData(title: viewModel.listProverbType[indexPath.row].title)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = R.storyboard.media.mediaDetailViewController() {
            if MediaType.list[segmentControl.selectedSegmentIndex] == .folk {
                vc.folkType = viewModel.listFolkType[indexPath.row]
            } else {
                vc.proverbType = viewModel.listProverbType[indexPath.row]
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
