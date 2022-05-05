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
    private var sourceMediaTypeList = [MediaTypeLocalModel]()
    var filteredMediaTypeList = [MediaTypeLocalModel]()
    
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
        DataManager.shared.getListMediaType { [weak self] list in
            guard let `self` = self else { return }
            self.sourceMediaTypeList = list
            self.filteredMediaTypeList = list
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
            filteredMediaTypeList = sourceMediaTypeList.filter { data in
                return data.mediaType == MediaType.folkVerses.value
            }
        } else {
            filteredMediaTypeList = sourceMediaTypeList.filter { (data: MediaTypeLocalModel) in
                if data.mediaType == MediaType.folkVerses.value {
                    let title = data.title.lowercased().unaccent()
                    let keyText = searchText.lowercased().unaccent()
                    if title.range(of: keyText) != nil {
                        return true
                    }
                }
                return false
            }
        }
    }
    
    private func filteProverbType() {
        if searchText == "" {
            filteredMediaTypeList = sourceMediaTypeList.filter { data in
                return data.mediaType == MediaType.proverb.value
            }
        } else {
            filteredMediaTypeList = sourceMediaTypeList.filter { (data: MediaTypeLocalModel) in
                if data.mediaType == MediaType.proverb.value {
                    let title = data.title.lowercased().unaccent()
                    let keyText = searchText.lowercased().unaccent()
                    if title.range(of: keyText) != nil {
                        return true
                    }
                }
                return false
            }
        }
    }
}
