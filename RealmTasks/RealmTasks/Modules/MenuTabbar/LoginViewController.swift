//
//  LoginViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import UIKit

struct MediaFile {
    var fileName: String
    var title: String
}

class LoginViewController: BaseViewController {
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndicatorView()
    }
    
    // MARK: - Actions
    @IBAction func vietnamClicked(_ sender: Any) {
        viewModel.setLanguage(languageKey: .vietnamese)
    }
    
    @IBAction func englishClicked(_ sender: Any) {
        viewModel.setLanguage(languageKey: .english)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if let vc = R.storyboard.main.baseNavigationController() {
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func tapToRestoreData(_ sender: UIButton) {
        showLoading()
        viewModel.handleMediaData {
            self.hideLoading()
        }
    }
    
    @IBAction func tapToDeleteData(_ sender: UIButton) {
    }
}
