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

class MediaDetailViewModel {
    var folkType = FolkTypeModel()
    var listFolks = [FolkModel]()
    var listString = [String]()
    var filterList = [String]()
    var listFavoriteFolk = [FavoriteFolkModel]()
    
    weak var delegate: MediaDetailViewModelDelegate?
    
    var searchText: String = "" {
        didSet(oldName) {
            print("Name changed from \(oldName) to \(searchText)")
            filterData()
        }
    }
    
    func addFavoriteFolk(data: FavoriteFolkModel) {
        DataMediaManager.shared.addFolkToRealm(data)
        delegate?.reloadData()
    }
    
    func removeFolk(folk: FavoriteFolkModel) {
        if DataMediaManager.shared.removeDataMedia(id: folk.id) {
            
        }
    }
    
    func checkFavoriteFolk(folk: FolkModel) -> Bool {
        for item in listFavoriteFolk {
            if item.content == folk.content {
                return true
            }
        }
        return false
    }
    
    func mappingFolkFavorite() {
        for i in 0..<listFolks.count {
            if checkFavoriteFolk(folk: listFolks[i]) {
                listFolks[i].isFavorite = true
            }
        }
    }
    
    func getListFavoriteFolk() {
        DataMediaManager.shared.getListFavoriteFolkFromRealm({ [weak self] list in
            guard let `self` = self else { return }
            self.listFavoriteFolk = list
            self.mappingFolkFavorite()
        })
    }
    
    func loadFile() {
        guard let fileName = folkType.fileName else { return }
        if let rtfPath = Bundle.main.url(forResource: fileName, withExtension: "rtf") {
            do {
                let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: rtfPath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                //                textView.attributedText = attributedStringWithRtf
                
                var item = FolkModel()
                var content = ""
                for char in attributedStringWithRtf.string {
                    if char == "*" {
                        item.id = UUID().uuidString
                        item.fileName = fileName
                        item.title = folkType.title
                        item.isFavorite = false
                        item.content = content
                        self.listFolks.append(item)
                        self.listString.append(content)
                        content = ""
                        item = FolkModel()
                    } else {
                        content.append(char)
                    }
                    print(char)
                }
                filterList = listString
                
            } catch let error {
                print("Got an error \(error)")
            }
        }
    }
    
    func filterData() {
        if searchText == "" {
            filterList = listString
        } else {
            filterList = listString.filter { (text: String) in
                let content = text.lowercased().unaccent()
                
                let keyText = searchText.lowercased().unaccent()
                
                if content.range(of: keyText) != nil {
                    
                    return true
                }
                return false
            }
        }
        
        delegate?.reloadData()
    }
}
