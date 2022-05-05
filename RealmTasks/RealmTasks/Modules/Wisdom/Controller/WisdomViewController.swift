//
//  WisdomViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import UIKit

class WisdomViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextDetail(_ sender: UIButton) {
        if let vc = R.storyboard.wisdom.wisdomDetailViewController() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
