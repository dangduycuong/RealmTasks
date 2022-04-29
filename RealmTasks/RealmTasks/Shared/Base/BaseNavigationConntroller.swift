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
        if let font = MenloFont.bold(with: 18) {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font]
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
