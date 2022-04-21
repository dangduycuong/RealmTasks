//
//  Identifier.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

//
// MARK: - Identifier
// Easily to get ViewID and XIB file
protocol Identifier {
    
    /// ID view
    static var identifierView: String {get}
    
    /// XIB - init XIB from identifierView
    static func xib() -> UINib?
}
