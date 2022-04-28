//
//  MediaDetailViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import Foundation

protocol MediaDetailViewModelDelegate: AnyObject {
    func reloadData()
}

struct MediaDisplayList {
    var id: String
    var fileName: String
    var title: String
    var content: String
    
    var isFavorite: Bool
}

class MediaDetailViewModel {
    var folkType = FolkTypeModel()
    var proverbType = ProverbTypeModel()
    
    var filteredList = [MediaDisplayList]()
    var sourceAllList = [MediaDisplayList]()
    var sourceFavoriteList = [MediaDisplayList]()
    
    var mediaType = MediaType.folkVerses
    
    weak var delegate: MediaDetailViewModelDelegate?
    
    var searchText: String = "" {
        didSet(oldName) {
            searchData()
        }
    }
    
    var valueChange: MediaDetailSegmentedControl = .all {
        didSet {
            searchData()
        }
    }
    
    func loadData(mediaType: MediaType, folkType: FolkTypeModel, proverbType: ProverbTypeModel) {
        self.mediaType = mediaType
        if mediaType == .folkVerses {
            self.folkType = folkType
            getListFolk()
        } else {
            self.proverbType = proverbType
            getListProverb()
        }
    }
    
    private func modifyFolk(folk: MediaDisplayList) {
        let dataEdit = FolkModel()
        dataEdit.id = folk.id
        dataEdit.fileName = folk.fileName
        dataEdit.content = folk.content
        dataEdit.title = folk.title
        dataEdit.isFavorite = folk.isFavorite
        DataManager.shared.modifyFolk(dataEdit: dataEdit)
        getListFolk()
    }
    
    private func modifyProverb(prover: MediaDisplayList) {
        let dataEdit = ProverbModel()
        dataEdit.id = prover.id
        dataEdit.fileName = prover.fileName
        dataEdit.content = prover.content
        dataEdit.title = prover.title
        dataEdit.isFavorite = prover.isFavorite
        DataManager.shared.modifyProverb(dataEdit: dataEdit)
        getListProverb()
    }
    
    func getListFolk() {
        DataManager.shared.getListFolk { [weak self] list in
            guard let `self` = self else { return }
            list.forEach({ data in
                guard data.fileName == self.folkType.fileName else { return }
                let item = MediaDisplayList(id: data.id, fileName: data.fileName, title: data.title, content: data.content, isFavorite: data.isFavorite)
                
                self.sourceAllList.append(item)
                self.filteredList.append(item)
                if data.isFavorite {
                    self.sourceFavoriteList.append(item)
                }
            })
        }
    }
    
    func getListProverb() {
        DataManager.shared.getListProverb { [weak self] list in
            guard let `self` = self else { return }
            list.forEach( { data in
                guard data.fileName == self.proverbType.fileName else { return }
                let item = MediaDisplayList(id: data.id, fileName: data.fileName, title: data.title, content: data.content, isFavorite: data.isFavorite)
                self.sourceAllList.append(item)
                self.filteredList.append(item)
                if data.isFavorite {
                    self.sourceFavoriteList.append(item)
                }
            })
        }
    }
    
    func filterData(sourceList: [MediaDisplayList]) {
        if searchText == "" {
            filteredList = sourceList
        } else {
            filteredList = sourceList.filter { (data: MediaDisplayList) in
                let content = data.content.lowercased().unaccent()
                let keyText = searchText.lowercased().unaccent()
                
                if content.range(of: keyText) != nil {
                    return true
                }
                return false
            }
        }
        
        delegate?.reloadData()
    }
    
    func modifyData(data: MediaDisplayList, type: MediaType) {
        removeAllData()
        switch type {
        case .folkVerses:
            modifyFolk(folk: data)
        case .proverb:
            modifyProverb(prover: data)
        }
        searchData()
    }
    
    private func searchData() {
        switch valueChange {
        case .all:
            filterData(sourceList: sourceAllList)
        case .favorite:
            filterData(sourceList: sourceFavoriteList)
        }
    }
    
    private func removeAllData() {
        sourceAllList.removeAll()
        sourceFavoriteList.removeAll()
        filteredList.removeAll()
    }
}
