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
}
