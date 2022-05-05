//
//  WisdomDetailViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import UIKit

class WisdomDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        addBackButton()
        tabBarController?.tabBar.isHidden = false
    }
    // MARK: - Navigation

}
