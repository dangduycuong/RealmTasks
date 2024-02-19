//
//  BaseNavigationConntroller.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        
        navigationBar.barTintColor = .black
        if let extraBold = PlayfairDisplayFont.extraBold(with: 20) {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.random, NSAttributedString.Key.font: extraBold]
        }
//        navigationBar.tintColor = .black
        
//        for family in UIFont.familyNames {
//            
//            let sName: String = family as String
//            print("family: \(sName)")
//            
//            for name in UIFont.fontNames(forFamilyName: sName) {
//                print("name: \(name as String)")
//            }
//        }
    }
}
