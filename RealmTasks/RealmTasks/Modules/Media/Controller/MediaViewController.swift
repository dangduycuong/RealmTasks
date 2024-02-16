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
    case poem
    
    static let list = [folkVerses, proverb, poem]
    
    var text: String {
        get {
            switch self {
            case .folkVerses:
                return R.string.localizable.folkVerses().language()
            case .proverb:
                return R.string.localizable.proverb().language()
            case .poem:
                return "Thơ"
            }
        }
    }
    
    var value: String {
        get {
            switch self {
            case .folkVerses:
                return "folkVerses"
            case .proverb:
                return "proverb"
            case .poem:
                return "poem"
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
        
        addObserver()
        
        setupUI()
        tableView.registerCell(MediaTableViewCell.self)
        tableView.register(with: PoemTableViewCell.self)
        viewModel.delegate = self
        viewModel.loadData()
        
        viewModel.mediaType = MediaType.list[segmentedControl.selectedSegmentIndex]
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotifi(notification:)), name: .openAllMedia, object: nil)
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
    }
    
    @objc func receivedNotifi(notification: Notification) {
        if let vc = R.storyboard.media.mediaAllViewController() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func openAllMedia(_ sender: UIButton) {
        if let vc = R.storyboard.media.mediaAllViewController() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setupUI() {
        for i in 0..<MediaType.list.count {
            segmentedControl.setTitle(MediaType.list[i].text, forSegmentAt: i)
        }
        
        if let bold = PlayfairDisplayFont.bold(with: 20) {
            let titleAttributes = [NSAttributedString.Key.font: bold, NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
            segmentedControl.backgroundColor = .black
            segmentedControl.selectedSegmentTintColor = UIColor.white.withAlphaComponent(0.4)
        }
        
        let mapTypeMenuIcon = UIImageView(image: R.image.icons8Menu_rounded())
        let buttonMapTypeMenuIcon = UIButton()
        view.layout(buttonMapTypeMenuIcon)
            .topSafe().right(16).width(44).height(44)
        
        view.layout(mapTypeMenuIcon)
            .center(buttonMapTypeMenuIcon).width(24).height(24)
        
        buttonMapTypeMenuIcon.addTarget(self, action: #selector(openAllMedia), for: .touchUpInside)
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
            cell.configure(title: item.title ?? "", description: item.content ?? "", note: item.note, keyWord: viewModel.searchText)
            return cell
        }
        let cell = tableView.dequeueReusableCell(cellType: MediaTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(title: viewModel.filteredMediaTypeList[indexPath.row].title)
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.mediaType == .poem {
            return
        }
        if let vc = R.storyboard.media.mediaDetailViewController() {
            let mediaType = viewModel.filteredMediaTypeList[indexPath.row]
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
