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
        
        var string = "CA DAO HAY VỀ CÁCH ĂN UỐNG"
        print(string.localizedCapitalized)
        string = string.unaccent().lowercased()
        let newString = string.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        print(newString)
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
        let jeremyGif = UIImage.gifImageWithName("loading")
        let imageView = UIImageView(image: jeremyGif)
//        imageView.frame = CGRect(x: 20.0, y: 50.0, width: self.view.frame.size.width - 40, height: 150.0)
//        view.addSubview(imageView)
        imageView.layer.cornerRadius = 25
        view.layout(imageView)
            .top().left().bottom().right()
        viewModel.handleMediaData {
            imageView.removeFromSuperview()
        }
    }
    
    @IBAction func tapToDeleteData(_ sender: UIButton) {
    }
}
