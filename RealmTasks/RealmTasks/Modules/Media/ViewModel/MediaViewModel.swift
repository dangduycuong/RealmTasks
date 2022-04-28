//
//  MediaViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import Foundation

protocol MediaViewModelDelegate: AnyObject {
    func updateData()
}

class MediaViewModel {
    var listFolkType = [FolkTypeModel]()
    var filteredFolkType = [FolkTypeModel]()
    var listProverbType = [ProverbTypeModel]()
    var filteredProverbType = [ProverbTypeModel]()
    
    var searchText: String = "" {
        didSet {
            filterData()
        }
    }
    
    var mediaType: MediaType = .folkVerses {
        didSet {
            filterData()
        }
    }
    
    weak var delegate: MediaViewModelDelegate?
    
    func loadData() {
        getListFolkType()
        getListProverbType()
    }
    
    private func getListFolkType() {
        DataManager.shared.getListFolkType { [weak self] list in
            guard let `self` = self else { return }
            self.listFolkType = list
            self.filteredFolkType = list
        }
    }
    
    private func getListProverbType() {
        DataManager.shared.getListProverbType { [weak self] list in
            guard let `self` = self else { return }
            self.listProverbType = list
            self.filteredProverbType = list
        }
    }
    
    private func filterData() {
        switch mediaType {
        case .folkVerses:
            filterFolkVersesType()
        case .proverb:
            filteProverbType()
        }
        delegate?.updateData()
    }
    
    private func filterFolkVersesType() {
        if searchText == "" {
            filteredFolkType = listFolkType
        } else {
            filteredFolkType = listFolkType.filter { (data: FolkTypeModel) in
                let title = data.title.lowercased().unaccent()
                let keyText = searchText.lowercased().unaccent()
                
                if title.range(of: keyText) != nil {
                    return true
                }
                return false
            }
        }
    }
    
    private func filteProverbType() {
        if searchText == "" {
            filteredProverbType = listProverbType
        } else {
            filteredProverbType = listProverbType.filter { (data: ProverbTypeModel) in
                let title = data.title.lowercased().unaccent()
                let keyText = searchText.lowercased().unaccent()
                
                if title.range(of: keyText) != nil {
                    return true
                }
                return false
            }
        }
    }
}
