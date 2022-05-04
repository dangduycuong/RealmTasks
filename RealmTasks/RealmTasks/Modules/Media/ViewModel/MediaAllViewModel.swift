//
//  MediaAllViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 30/04/2022.
//

import Foundation

class MediaAllViewModel {
    var filteredAllList = [MediaDisplayList]()
    private var sourceAllList = [MediaDisplayList]()
    private var sourceFolkVerses = [FolkVersesModel]()
    private var sourceProverb = [ProverbModel]()
    
    func loadData(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let dispatchGroup = DispatchGroup()

            dispatchGroup.enter()
            self.loadFolkVerses {
                dispatchGroup.leave()
            }

            dispatchGroup.enter()
            self.loadProverb {
                dispatchGroup.leave()
            }

            dispatchGroup.wait()

            dispatchGroup.enter()
            self.sortSourceAllData {
                dispatchGroup.leave()
            }

            dispatchGroup.notify(queue: .main, execute: {
                completion()
            })
        }
    }
    
    private func loadFolkVerses(completion: @escaping () -> Void) {
        DataManager.shared.getListFolk { [weak self] list in
            guard let `self` = self else { return }
            self.sourceFolkVerses = list
            completion()
        }
    }
    
    private func loadProverb(completion: @escaping () -> Void) {
        DataManager.shared.getListProverb { [weak self] list in
            guard let `self` = self else { return }
            self.sourceProverb = list
            completion()
        }
    }
    
    private func sortSourceAllData(completion: @escaping () -> Void) {
        sourceFolkVerses.forEach( { data in
            let item = MediaDisplayList(id: data.id, fileName: data.fileName, title: data.title, content: data.content, isFavorite: data.isFavorite)
            sourceAllList.append(item)
        })
        sourceProverb.forEach( { data in
            let item = MediaDisplayList(id: data.id, fileName: data.fileName, title: data.title, content: data.content, isFavorite: data.isFavorite)
            sourceAllList.append(item)
        })
        filteredAllList = sourceAllList.sorted { $0.content.lowercased() < $1.content.lowercased() }
        completion()
    }
    
}
