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
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1", "2", "3"])
        segmentedControl.addTarget(self, action: #selector(segmentedControlClicked), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var searchView: NimsTinhChinhCapView = {
        let view: NimsTinhChinhCapView = NimsTinhChinhCapView.loadFromNib()
        view.backgroundColor = UIColor.random.withAlphaComponent(0.4)
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var viewModel = MediaViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
        
        tableView.registerCell(MediaTableViewCell.self)
        tableView.register(with: PoemTableViewCell.self)
        viewModel.delegate = self
        viewModel.loadData()
        segmentedControl.selectedSegmentIndex = 0
        viewModel.mediaType = MediaType.list[segmentedControl.selectedSegmentIndex]
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: "Giải Trí")
        
        let mapTypeMenuIcon = UIImageView(image: R.image.icons8Menu_rounded())
        let buttonMapTypeMenuIcon = UIButton()
        view.layout(buttonMapTypeMenuIcon)
            .topSafe().right(16).width(44).height(44)
        
        view.layout(mapTypeMenuIcon)
            .center(buttonMapTypeMenuIcon).width(24).height(24)
        
        buttonMapTypeMenuIcon.addTarget(self, action: #selector(openAllMedia), for: .touchUpInside)
        
        view.layout(segmentedControl)
            .below(titleLabel, 32).left(16).right(16).height(40)
        for i in 0..<MediaType.list.count {
            segmentedControl.setTitle(MediaType.list[i].text, forSegmentAt: i)
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
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotifi(notification:)), name: .openAllMedia, object: nil)
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
    }
    
    @objc func receivedNotifi(notification: Notification) {
        let vc = MediaAllViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openAllMedia(_ sender: UIButton) {
        let vc = MediaAllViewController()
        navigationController?.pushViewController(vc, animated: true)
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
        let vc = MediaDetailViewController()
        let mediaType = viewModel.filteredMediaTypeList[indexPath.row]
        vc.mediaType = mediaType
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MediaViewController: MediaViewModelDelegate {
    func updateData() {
        tableView.reloadData()
    }
}
