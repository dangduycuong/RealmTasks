//
//  MediaViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import Foundation

class MediaViewModel {
    var listFolkType: [FolkTypeModel] = [
        FolkTypeModel(fileName: "lao_dong_san_xuat", title: "Lao động sản xuất"),
        FolkTypeModel(fileName: "ca_dao_hoc_tap", title: "Học tập"),
        FolkTypeModel(fileName: "ca_dao_an_noi_ung_xu", title: "Lời ăn tiếng nói"),
        FolkTypeModel(fileName: "ca_dao_tinh_yeu_nam_nu", title: "Tình yêu nam nữ"),
    ]
    
    var listProverbType: [ProverbType] = [
        ProverbType(fileName: "tuc_ngu_tinh_yeu_nam_nu", title: "Tình yêu nam nữ"),
    ]
}
