//
//  Notification+Name.swift
//  RealmTasks
//
//  Created by cuongdd on 29/04/2022.
//

import Foundation

extension Notification.Name {
    static var changeMapType: Notification.Name {
        return .init(rawValue: "changeMapType")
    }
    
    static var openAllMedia: Notification.Name {
        return .init(rawValue: "openAllMedia")
    }
}
