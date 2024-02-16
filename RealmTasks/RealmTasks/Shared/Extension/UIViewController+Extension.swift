//
//  UIViewController+Extension.swift
//  RealmTasks
//
//  Created by cuongdd on 05/02/2024.
//

import UIKit

extension UIViewController {
    func embedInNavigationController() -> UINavigationController {
        let navi = UINavigationController(rootViewController: self)
        navi.isMotionEnabled = true
        navi.navigationBar.isHidden = true
        return navi
    }
}
