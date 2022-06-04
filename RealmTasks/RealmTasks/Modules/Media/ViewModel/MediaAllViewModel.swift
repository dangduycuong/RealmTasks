//
//  MediaAllViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 30/04/2022.
//

import Foundation

protocol MediaAllViewModelDelegate: AnyObject {
    func reloadData()
}

class MediaAllViewModel {
    var filteredResultList = [MediaDetailDisplay]()
    private var sourceMediaList = [MediaDetailDisplay]()
    
    weak var delegate: MediaAllViewModelDelegate?
    
    var searchText: String = "" {
        didSet {
            filterData()
        }
    }
    
    var displayType: MediaAllViewSegmented = .all {
        didSet {
            filterData()
        }
    }
    
    func loadData(completion: @escaping () -> Void) {
        getListMedia {
            completion()
        }
    }
    
    private func getListMedia(completion: @escaping () -> Void) {
        DataManager.shared.getListMedia { [weak self] list in
            guard let `self` = self else { return }
            list.forEach( { data in
                let item = MediaDetailDisplay(
                    id: data.id,
                    fileName: data.fileName,
                    title: data.title,
                    content: data.content,
                    mediaType: data.mediaType,
                    isFavorite: data.isFavorite
                )
                self.sourceMediaList.append(item)
            })
            let temp = self.sourceMediaList.sorted { $0.content.lowercased() < $1.content.lowercased() }
            self.sourceMediaList = temp
            self.filteredResultList = self.sourceMediaList
            completion()
        }
    }
    
    private func filterData() {
        switch displayType {
        case .all:
            filterListDataAll()
        case .folkVerses:
            filterFolkVerses()
        case .proverb:
            filterProverb()
        case .favorite:
            filterFavorite()
        }
        delegate?.reloadData()
    }
    
    private func filterListDataAll() {
        if searchText == "" {
            filteredResultList = sourceMediaList
        } else {
            let keyWord = searchText.unaccent().lowercased()
            filteredResultList = sourceMediaList.filter( { data in
                let content = data.content.unaccent().lowercased()
                if content.range(of: keyWord) != nil {
                    return true
                }
                return false
            })
        }
    }
    
    private func filterFolkVerses() {
        if searchText == "" {
            filteredResultList.removeAll()
            sourceMediaList.forEach { data in
                if data.mediaType == MediaType.folkVerses.value {
                    filteredResultList.append(data)
                }
            }
        } else {
            let keyWord = searchText.unaccent().lowercased()
            filteredResultList = sourceMediaList.filter( { data in
                if data.mediaType == MediaType.folkVerses.value {
                    let content = data.content.unaccent().lowercased()
                    if content.range(of: keyWord) != nil {
                        return true
                    }
                }
                return false
            })
        }
    }
    
    private func filterProverb() {
        if searchText == "" {
            filteredResultList.removeAll()
            sourceMediaList.forEach { data in
                if data.mediaType == MediaType.proverb.value {
                    filteredResultList.append(data)
                }
            }
        } else {
            let keyWord = searchText.unaccent().lowercased()
            filteredResultList = sourceMediaList.filter( { data in
                if data.mediaType == MediaType.proverb.value {
                    let content = data.content.unaccent().lowercased()
                    if content.range(of: keyWord) != nil {
                        return true
                    }
                }
                return false
            })
        }
    }
    
    private func filterFavorite() {
        if searchText == "" {
            filteredResultList = sourceMediaList.filter { data in
                return data.isFavorite
            }
        } else {
            let keyWord = searchText.unaccent().lowercased()
            filteredResultList = sourceMediaList.filter( { data in
                if data.isFavorite {
                    let content = data.content.unaccent().lowercased()
                    if content.range(of: keyWord) != nil {
                        return true
                    }
                }
                return false
            })
        }
    }
    
    func modifyData(media: MediaDetailDisplay) {
        removeAllData()
        modifyMedia(media: media)
    }
    
    private func modifyMedia(media: MediaDetailDisplay) {
        let dataEdit = MediaDetailLocalModel()
        dataEdit.id = media.id
        dataEdit.fileName = media.fileName
        dataEdit.content = media.content
        dataEdit.title = media.title
        dataEdit.mediaType = media.mediaType
        dataEdit.isFavorite = media.isFavorite
        DataManager.shared.modifyMedia(dataEdit: dataEdit)
        
        getListMedia {
            self.filterData()
        }
    }
    
    private func removeAllData() {
        filteredResultList.removeAll()
        sourceMediaList.removeAll()
    }
    
}
