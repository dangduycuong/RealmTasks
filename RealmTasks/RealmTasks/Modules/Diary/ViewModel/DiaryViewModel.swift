//
//  DiaryViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 25/02/2024.
//

import Foundation
import RealmSwift
import RxRelay

class DiaryViewModel: BaseViewModel {
    var fetchedDiaryDataSource = BehaviorRelay<[DiaryModel]>(value: [])
    lazy var realm = try! Realm()
    private var listDiary: Results<DiaryModel> {
        get {
            return realm.objects(DiaryModel.self)
        }
    }
    
    var searchText: String? = "" {
        didSet {
            filterText(searchText)
        }
    }
    
    func loadData() {
        DataManager.shared.getListDiaryFromRealm { list in
            self.fetchedDiaryDataSource.accept(list)
        }
    }
    
    func removeItem(at index: Int) {
        _ = DataManager.shared.removeDiaryItem(id: fetchedDiaryDataSource.value[index].id)
        fetchedDiaryDataSource.accept(listDiary.toArray(ofType: DiaryModel.self))
    }
    
    private func filterText(_ searchText: String?) {
        let list = filterByText(searchText: searchText, sourceList: listDiary.toArray(ofType: DiaryModel.self))
        fetchedDiaryDataSource.accept(list)
    }
    
    private func filterByText(searchText: String?, sourceList: [DiaryModel]) -> [DiaryModel] {
        let keyWord: String = (searchText ?? "").lowercased().unaccent()
        
        if keyWord == "" {
            return sourceList
        }
        
        var list = [DiaryModel]()
        
        list = sourceList.filter { (model: DiaryModel) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-YYYY, HH:mm:ss"
            let dateString = dateFormatter.string(from: model.dateTime)
            let content = model.content.lowercased().unaccent()
            
            if content.range(of: keyWord) != nil {
                return true
            }
            if dateString.range(of: keyWord) != nil {
                return true
            }
            return false
        }
        return list
    }
}
