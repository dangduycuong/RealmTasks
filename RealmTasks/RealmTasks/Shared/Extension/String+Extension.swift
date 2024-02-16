//
//  String+Extension.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import Foundation

extension String {
    func unaccent() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
    
    var folded: String {
        return self.folding(options: .diacriticInsensitive, locale: nil)
            .replacingOccurrences(of: "đ", with: "d")
            .replacingOccurrences(of: "Đ", with: "D")
    }
}

// language
extension String {
    static func random(length: Int = 10) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    
    func language() -> String{
        return VTLocalizedString.localized(key: self)
    }
    
    func localizedString() -> String {
        return LocalizationHandlerUtil.shareInstance().localizedString(self, comment: nil)
    }
    
}

struct VTLocalizedString {
    static func localized(key: String) -> String{
        return key.localizedString()
    }
}
