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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(MediaTableViewCell.self)
    }
    
    private func setupUI() {
        for i in 0..<MediaAllViewSegmented.list.count {
            segmentedControl.setTitle(MediaAllViewSegmented.list[i].text, forSegmentAt: i)
        }
        
        if let bold = MenloFont.bold(with: 16) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = .black
            segmentedControl.selectedSegmentTintColor = .black
        }
    }

}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension MediaAllViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MediaTableViewCell.self, forIndexPath: indexPath)
        return cell
    }
    
    
}
