//
//  LoginViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import UIKit

class LoginViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func vietnamClicked(_ sender: Any) {
        LocalizationHandlerUtil.shareInstance().setLanguageIdentifier("vi")
        let current = "vi"
        LocalData.saveToLocal(value: current, key: LocalKey.currentLanguage.rawValue)
    }
    
    @IBAction func englishClicked(_ sender: Any) {
        LocalizationHandlerUtil.shareInstance().setLanguageIdentifier("en")
        let current = "en"
        LocalData.saveToLocal(value: current, key: LocalKey.currentLanguage.rawValue)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if let vc = R.storyboard.main.baseNavigationController() {
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
    
}
