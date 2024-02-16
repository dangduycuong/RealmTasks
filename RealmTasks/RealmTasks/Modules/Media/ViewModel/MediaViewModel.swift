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
    var poemsModel = [Poem]()
    private var poemsSourceModel = [Poem]()
    
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
        readJSONFile(forName: "Tagore")
        DataManager.shared.getListMediaType { [weak self] list in
            guard let `self` = self else { return }
            self.sourceMediaTypeList = list
            self.filteredMediaTypeList = list
        }
    }
    
    private func readJSONFile(forName name: String) {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let poemModel = try? JSONDecoder().decode(PoemModel.self, from: jsonData)
                if let poems = poemModel?.poems {
                    self.poemsModel = poems
                    self.poemsSourceModel = poems
                }
                
                if let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String: Any] {
                    print("JSON: \(json)")
                } else {
                    print("Given JSON is not a valid dictionary object.")
                }
            }
        } catch {
            print(error)
        }
    }
    
    private func filterData() {
        switch mediaType {
        case .folkVerses:
            filterFolkVersesType()
        case .proverb:
            filteProverbType()
        case .poem:
            filtePoemType()
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
    
    private func filtePoemType() {
        if searchText == "" {
            poemsModel = poemsSourceModel
        } else {
            poemsModel = poemsSourceModel.filter { (data: Poem) in
                let title = data.title?.lowercased().unaccent() ?? ""
                let content = data.content?.lowercased().unaccent() ?? ""
                let note = data.note?.lowercased().unaccent() ?? ""
                let keyText = searchText.lowercased().unaccent()
                if title.range(of: keyText) != nil {
                    return true
                }
                if content.range(of: keyText) != nil {
                    return true
                }
                if note.range(of: keyText) != nil {
                    return true
                }
                return false
            }
        }
    }
}
