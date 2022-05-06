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

protocol LoginViewModelDelegate: AnyObject {
    func verifySuccess()
}

class LoginViewModel {
    
    let pickerDataSize = 100_000
    var dataSource = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]]
    var password = [[0], [0], [0], [0]] {
        didSet {
            verifyPassword()
        }
    }
    weak var delegate: LoginViewModelDelegate?
    
    private func verifyPassword() {
        let verify = [[2], [5], [9], [3]]
        if password == verify {
            delegate?.verifySuccess()
        }
    }
    
    func setLanguage(languageKey: LanguageKey) {
        LocalizationHandlerUtil.shareInstance().setLanguageIdentifier(languageKey.value)
        LocalData.saveToLocal(value: languageKey.value, key: LocalKey.currentLanguage.rawValue)
    }
    
    private func saveMediaTypes(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let listFile: [MediaFile] = [
                MediaFile(fileName: "lao_dong_san_xuat", title: "Lao động sản xuất", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_hoc_tap", title: "Học tập", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_an_noi_ung_xu", title: "Lời ăn tiếng nói", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_tinh_yeu_nam_nu", title: "Tình yêu nam nữ", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_cha_me", title: "Cha mẹ", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_an_uong", title: "Ăn uống", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_tinh_nghia_vo_chong", title: "Tình nghĩa vợ chồng", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_hai_huoc", title: "Hài hước", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_tinh_kien_tri", title: "Tính kiên trì", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_viet_nam_hay_nhat", title: "Việt Nam Hay Nhất", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_viet_nam_hay_nhat", title: "Ca Dao Về Người Phụ Nữ Việt Nam", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_ve_y_chi_nghi_luc", title: "Ca Dao Về Ý Chí Nghị Lực", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_ve_thuoc_thang", title: "Ca Dao Về Thuốc Thang", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_đac_sac_va_giau_triet_ly_song", title: "Ca Dao Đặc Sắc Và Giàu Triết Lý Sống", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "ca_dao_hay_ve_cach_an_uong", title: "Ca Dao Hay Về Cách Ăn Uống", mediaType: MediaType.folkVerses.value),
                MediaFile(fileName: "tuc_ngu_hoc_tap", title: "Tục ngự học tập", mediaType: MediaType.proverb.value),
                MediaFile(fileName: "tuc_ngu_tinh_yeu_nam_nu", title: "Tình yêu nam nữ", mediaType: MediaType.proverb.value),
                MediaFile(fileName: "tuc_ngu_cha_me", title: "Cha mẹ", mediaType: MediaType.proverb.value),
                MediaFile(fileName: "tuc_ngu_an_uong", title: "Ăn uống", mediaType: MediaType.proverb.value),
                MediaFile(fileName: "tuc_ngu_suc_khoe", title: "Sức khoẻ", mediaType: MediaType.proverb.value),
                MediaFile(fileName: "tuc_ngu_vo_chong", title: "Vợ chồng", mediaType: MediaType.proverb.value),
                MediaFile(fileName: "tuc_ngu_tinh_kien_tri", title: "Tính kiên trì", mediaType: MediaType.proverb.value),
                MediaFile(fileName: "tuc_ngu_ve_y_chi_nghi_luc", title: "Tục Ngữ Về Ý Chí Nghị Lực", mediaType: MediaType.proverb.value),
            ]
            
            for file in listFile {
                let item = MediaTypeLocalModel()
                item.id = UUID().uuidString
                item.fileName = file.fileName
                item.title = file.title
                item.mediaType = file.mediaType
                DataManager.shared.addMediaTypeToRealm(item)
            }
            completion()
        }
    }
    
    private func saveMedias(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            DataManager.shared.getListMediaType { [weak self] list in
                guard let `self` = self else { return }
                for mediaTypeItem in list {
                    let fileName = mediaTypeItem.fileName
                    if let string = self.getTextInRTFFile(fileName: fileName) {
                        var item = MediaDetailLocalModel()
                        var content = ""
                        for char in string {
                            if char == "*" {
                                item.id = UUID().uuidString
                                item.fileName = fileName
                                item.title = mediaTypeItem.title
                                item.isFavorite = false
                                item.content = content
                                item.mediaType = mediaTypeItem.mediaType
                                DataManager.shared.addMediaToRealm(item)
                                content = ""
                                item = MediaDetailLocalModel()
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
            self.deleteMediaType {
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.deleteMedia {
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
            self.saveMediaTypes {
                dispatchGroup.leave()
            }
            
            dispatchGroup.wait()
            
            dispatchGroup.enter()
            self.saveMedias {
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                completion()
            }
        }
    }
    
    private func deleteMediaType(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            DataManager.shared.deleteMediaType {
                completion()
            }
        }
    }
    
    private func deleteMedia(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            DataManager.shared.deleteMedia {
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
