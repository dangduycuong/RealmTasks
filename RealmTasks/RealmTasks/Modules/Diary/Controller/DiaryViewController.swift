//
//  DiaryViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/02/2024.
//

import UIKit
import RealmSwift
import RxSwift

class DiaryViewController: BaseViewController {
    private var viewModel = DiaryViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addObserver()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(with: DiaryTableViewCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.loadData()
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: "Nhật Ký")
        
        view.layout(searchView)
            .below(titleLabel, 32).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottom().right()
        
        setupAddDataButton()
    }
    
    private func addObserver() {
        searchView.searchText = { text in
            self.viewModel.searchText = text
        }
        
        viewModel.fetchedDiaryDataSource.skip(1).observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] list in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    override func nextDetail(_ sender: UIButton) {
        let vc = DiaryEditViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension DiaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchedDiaryDataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: DiaryTableViewCell.self, forIndexPath: indexPath)
        let diary = viewModel.fetchedDiaryDataSource.value[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY, HH:mm:ss"
        cell.configure(title: dateFormatter.string(from: diary.dateTime), description: diary.content, searchText: viewModel.searchText)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DiaryEditViewController()
        vc.diaryModel = viewModel.fetchedDiaryDataSource.value[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeItem(at: indexPath.row)
        }
    }
}

