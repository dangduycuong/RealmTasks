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

struct MediaDetailDisplay {
    var id: String
    var fileName: String
    var title: String
    var content: String
    
    var mediaType: String
    var isFavorite: Bool
}

class MediaDetailViewModel {
    
    var filteredList = [MediaDetailDisplay]()
    private var sourceAllList = [MediaDetailDisplay]()
    private var sourceFavoriteList = [MediaDetailDisplay]()
    
    var mediaType = MediaTypeLocalModel()
    
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
    
    func loadData(mediaType: MediaTypeLocalModel) {
        self.mediaType = mediaType
        getListMedia(mediaType: mediaType)
    }
    
    private func getListMedia(mediaType: MediaTypeLocalModel) {
        DataManager.shared.getListMedia { [weak self] list in
            guard let `self` = self else { return }
            list.forEach({ data in
                guard data.fileName == mediaType.fileName else { return }
                let item = MediaDetailDisplay(id: data.id, fileName: data.fileName, title: data.title, content: data.content, mediaType: data.mediaType, isFavorite: data.isFavorite)
                self.setupData(data: item)
            })
        }
    }
    
    private func setupData(data: MediaDetailDisplay) {
        sourceAllList.append(data)
        filteredList.append(data)
        if data.isFavorite {
            sourceFavoriteList.append(data)
        }
    }
    
    func filterData(sourceList: [MediaDetailDisplay]) {
        if searchText == "" {
            filteredList = sourceList
        } else {
            filteredList = sourceList.filter { (data: MediaDetailDisplay) in
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
    
    func modifyData(media: MediaDetailDisplay) {
        removeAllData()
        let dataEdit = MediaDetailLocalModel()
        dataEdit.id = media.id
        dataEdit.fileName = media.fileName
        dataEdit.title = media.title
        dataEdit.content = media.content
        dataEdit.mediaType = media.mediaType
        dataEdit.isFavorite = media.isFavorite
        DataManager.shared.modifyMedia(dataEdit: dataEdit)
        getListMedia(mediaType: self.mediaType)
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
