//
//  MediaViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import Foundation

class MediaViewModel {
    var listFolkType = [FolkTypeModel]()
    
    var listProverbType = [ProverbTypeModel]()
    
    func loadData() {
        getListFolkType()
        getListProverbType()
    }
    
    private func getListFolkType() {
        DataManager.shared.getListFolkType { [weak self] list in
            guard let `self` = self else { return }
            self.listFolkType = list
        }
    }
    
    private func getListProverbType() {
        DataManager.shared.getListProverbType { [weak self] list in
            guard let `self` = self else { return }
            self.listProverbType = list
        }
    }
}
