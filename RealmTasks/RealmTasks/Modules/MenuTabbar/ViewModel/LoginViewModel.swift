//
//  LoginViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 27/04/2022.
//

import Foundation

enum LanguageKey {
    case english
    case vietnamese
    
    var value: String {
        get {
            switch self {
            case .english:
                return "en"
            case .vietnamese:
                return "vi"
            }
        }
    }
}


class LoginViewModel {
    
    func setLanguage(languageKey: LanguageKey) {
        LocalizationHandlerUtil.shareInstance().setLanguageIdentifier(languageKey.value)
        LocalData.saveToLocal(value: languageKey.value, key: LocalKey.currentLanguage.rawValue)
    }
    
    private func saveFolkTypes(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let listFile: [MediaFile] = [
                MediaFile(fileName: "lao_dong_san_xuat", title: "Lao động sản xuất"),
                MediaFile(fileName: "ca_dao_hoc_tap", title: "Học tập"),
                MediaFile(fileName: "ca_dao_an_noi_ung_xu", title: "Lời ăn tiếng nói"),
                MediaFile(fileName: "ca_dao_tinh_yeu_nam_nu", title: "Tình yêu nam nữ"),
                MediaFile(fileName: "ca_dao_cha_me", title: "Cha mẹ"),
                MediaFile(fileName: "ca_dao_an_uong", title: "Ăn uống"),
                MediaFile(fileName: "ca_dao_tinh_nghia_vo_chong", title: "Tình nghĩa vợ chồng"),
                MediaFile(fileName: "ca_dao_hai_huoc", title: "Hài hước"),
                MediaFile(fileName: "ca_dao_tinh_kien_tri", title: "Tính kiên trì"),
                MediaFile(fileName: "ca_dao_viet_nam_hay_nhat", title: "Việt Nam Hay Nhất"),
                MediaFile(fileName: "ca_dao_viet_nam_hay_nhat", title: "Ca Dao Về Người Phụ Nữ Việt Nam"),
                MediaFile(fileName: "ca_dao_ve_y_chi_nghi_luc", title: "Ca Dao Về Ý Chí Nghị Lực"),
                
            ]
            
            for file in listFile {
                let item = FolkTypeModel()
                item.id = UUID().uuidString
                item.fileName = file.fileName
                item.title = file.title
                DataManager.shared.addFolkTypeToRealm(item)
            }
            completion()
        }
    }
    
    private func saveFolks(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            DataManager.shared.getListFolkType { [weak self] list in
                guard let `self` = self else { return }
                for folkType in list {
                    let fileName = folkType.fileName
                    if let string = self.getTextInRTFFile(fileName: fileName) {
                        var item = FolkModel()
                        var content = ""
                        for char in string {
                            if char == "*" {
                                item.id = UUID().uuidString
                                item.fileName = fileName
                                item.title = folkType.title
                                item.isFavorite = false
                                item.content = content
                                DataManager.shared.addFolkToRealm(item)
                                content = ""
                                item = FolkModel()
                            } else {
                                content.append(char)
                            }
                        }
                    }
                }
                completion()
            }
        }
    }
    
    private func saveProverbTypes(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let listFile: [MediaFile] = [
                MediaFile(fileName: "tuc_ngu_hoc_tap", title: "Tục ngự học tập"),
                MediaFile(fileName: "tuc_ngu_tinh_yeu_nam_nu", title: "Tình yêu nam nữ"),
                MediaFile(fileName: "tuc_ngu_cha_me", title: "Cha mẹ"),
                MediaFile(fileName: "tuc_ngu_an_uong", title: "Ăn uống"),
                MediaFile(fileName: "tuc_ngu_suc_khoe", title: "Sức khoẻ"),
                MediaFile(fileName: "tuc_ngu_vo_chong", title: "Vợ chồng"),
                MediaFile(fileName: "tuc_ngu_tinh_kien_tri", title: "Tính kiên trì"),
                MediaFile(fileName: "tuc_ngu_ve_y_chi_nghi_luc", title: "Tục Ngữ Về Ý Chí Nghị Lực"),
            ]
            
            for file in listFile {
                let item = ProverbTypeModel()
                item.id = UUID().uuidString
                item.fileName = file.fileName
                item.title = file.title
                DataManager.shared.addProverbType(item)
            }
            completion()
        }
    }
    
    private func saveProverbs(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            DataManager.shared.getListProverbType { [weak self] list in
                guard let `self` = self else { return }
                for roverbType in list {
                    let fileName = roverbType.fileName
                    if let string = self.getTextInRTFFile(fileName: fileName) {
                        var item = ProverbModel()
                        var content = ""
                        for char in string {
                            if char == "*" {
                                item.id = UUID().uuidString
                                item.fileName = fileName
                                item.title = roverbType.title
                                item.isFavorite = false
                                item.content = content
                                DataManager.shared.addProverb(item)
                                content = ""
                                item = ProverbModel()
                            } else {
                                content.append(char)
                            }
                        }
                    }
                }
                completion()
            }
        }
    }
    
    private func deleteData(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            self.deleteFolkType {
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            self.deleteFolk {
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            self.deleteProverbType {
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            self.deleteProverb {
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                completion()
            }
        }
    }
    
    private func saveData(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            self.saveFolkTypes {
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.saveProverbTypes {
                dispatchGroup.leave()
            }
            
            dispatchGroup.wait()
            
            dispatchGroup.enter()
            self.saveFolks {
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.saveProverbs {
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main) {
                completion()
            }
        }
    }
    
    private func deleteFolkType(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            DataManager.shared.deleteFolkType {
                completion()
            }
        }
    }
    
    private func deleteFolk(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            DataManager.shared.deleteFolk {
                completion()
            }
        }
    }
    
    private func deleteProverbType(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            DataManager.shared.deleteProverbType {
                completion()
            }
        }
    }
    
    private func deleteProverb(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            DataManager.shared.deleteProverb {
                completion()
            }
        }
    }
    
    private func getTextInRTFFile(fileName: String) -> String? {
        if let rtfPath = Bundle.main.url(forResource: fileName, withExtension: "rtf") {
            do {
                let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: rtfPath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                return attributedStringWithRtf.string
            } catch let error {
                print("Got an error \(error)")
            }
        }
        return nil
    }
    
    func handleMediaData(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            print("tapToRestoreData")
            //            self.showLoading()
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            self.deleteData {
                dispatchGroup.leave()
            }
            
            dispatchGroup.wait()
            
            dispatchGroup.enter()
            self.saveData {
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                completion()
            }
        }
    }
    
}
