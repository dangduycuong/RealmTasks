//
//  WisdomDetailViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 06/05/2022.
//

import Foundation

enum WisdomTaskResult {
    case add
    case modify
    case delete
    case error
}

protocol WisdomDetailViewModelDelegate: AnyObject {
    func showResultAction(task: WisdomTaskResult)
}

class WisdomDetailViewModel {
    private var wisdom = WisdomModel()
    weak var delegate: WisdomDetailViewModelDelegate?
    private var isViewWisdomDetail: Bool = false
    
    func setupData(isViewWisdomDetail: Bool, wisdom: WisdomModel) {
        self.isViewWisdomDetail = isViewWisdomDetail
        if isViewWisdomDetail {
            self.wisdom = wisdom
        }
    }
    
    func addWisdom(content: String?) {
        guard let content = content, content != "" else {
            delegate?.showResultAction(task: .error)
            return
        }
        let wisdom = WisdomModel()
        wisdom.id = UUID().uuidString
        wisdom.content = content
        
        if isViewWisdomDetail {
            isViewWisdomDetail = false
            modifyWisdom(content: content)
        } else {
            DataManager.shared.addWisdomToRealm(wisdom)
            delegate?.showResultAction(task: .add)
        }
    }
    
    func modifyWisdom(content: String) {
        let dataChange = WisdomModel()
        dataChange.id = wisdom.id
        dataChange.content = content
        DataManager.shared.modifyWisdom(dataEdit: dataChange)
        delegate?.showResultAction(task: .modify)
    }
    
    func deleteModify() {
        if DataManager.shared.removeWisdomItem(id: wisdom.id) {
            isViewWisdomDetail = false
            delegate?.showResultAction(task: .delete)
        }
    }
}
