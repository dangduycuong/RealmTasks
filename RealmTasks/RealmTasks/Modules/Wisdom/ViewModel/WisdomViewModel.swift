//
//  WisdomViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 07/05/2022.
//

import Foundation

protocol WisdomViewModelDelegate: AnyObject {
    func updateData()
}

class WisdomViewModel {
    private var listWisdom = [WisdomModel]()
    var filteredListWisdom = [WisdomModel]()
    weak var delegate: WisdomViewModelDelegate?
    
    var searchText: String = "" {
        didSet {
            filterData()
        }
    }
    
    func loadData() {
        getListWisdom {
            self.filterData()
        }
    }
    
    private func getListWisdom(completion: @escaping(() -> Void)) {
        DataManager.shared.getListWisdomFromRealm { [weak self] list in
            guard let `self` = self else {
                return
            }
            self.listWisdom = list
            self.filteredListWisdom = list
            completion()
        }
    }
    
    func removeWisdomItem(wisdom: WisdomModel) {
        if DataManager.shared.removeWisdomItem(id: wisdom.id) {
            getListWisdom {
                self.filterData()
            }
        }
    }
    
    private func filterData() {
        if searchText == "" {
            filteredListWisdom = listWisdom
        } else {
            let keyWord = searchText.unaccent().lowercased()
            filteredListWisdom = listWisdom.filter { data in
                let content = data.content.unaccent().lowercased()
                if content.range(of: keyWord) != nil {
                    return true
                }
                return false
            }
        }
        delegate?.updateData()
    }
}
