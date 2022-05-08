//
//  WisdomViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import UIKit

class WisdomViewController: BaseViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: SearchView!
    
    var viewModel = WisdomViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableView.registerCell(WisdomTableViewCell.self)
        viewModel.delegate = self
        searchView.searchText = { [weak self] text in
            guard let `self` = self else { return }
            self.viewModel.searchText = text
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadData()
    }
    
    private func setupUI() {
//        let jeremyGif = UIImage.gifImageWithName("galaxy")
//
//        let imageView = UIImageView(image: jeremyGif)
//        imageView.layer.cornerRadius = 25
//        backgroundImageView.layout(imageView)
//            .top().left().bottom().right()
        
        addButton.setTitle("", for: .normal)
        addButton.layer.cornerRadius = 20
        addButton.layer.shadowColor = UIColor.white.cgColor
        addButton.layer.shadowOpacity = 1
        addButton.layer.shadowOffset = .zero
        addButton.layer.shadowRadius = 8
    }
    
    @IBAction func nextDetail(_ sender: UIButton) {
        if let vc = R.storyboard.wisdom.wisdomDetailViewController() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension WisdomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredListWisdom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: WisdomTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(content: viewModel.filteredListWisdom[indexPath.row].content)
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = R.storyboard.wisdom.wisdomDetailViewController() {
            vc.wisdom = viewModel.filteredListWisdom[indexPath.row]
            vc.isViewWisdomDetail = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeWisdomItem(wisdom: viewModel.filteredListWisdom[indexPath.row])
        }
    }
}

extension WisdomViewController: WisdomViewModelDelegate {
    func updateData() {
        tableView.reloadData()
    }
}
