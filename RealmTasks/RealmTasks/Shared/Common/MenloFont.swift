//
//  MenloFont.swift
//  RealmTasks
//
//  Created by cuongdd on 22/04/2022.
//

import UIKit

struct MenloFont {
    static func boldItalic(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Menlo-BoldItalic", size: size)
    }
    
    static func bold(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Menlo-Bold", size: size)
    }
    
    static func italic(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Menlo-Italic", size: size)
    }
    
    static func regular(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Menlo-Regular", size: size)
    }
}
