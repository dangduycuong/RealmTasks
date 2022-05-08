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
    var mediaType: String
}

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupIndicatorView()
        viewModel.delegate = self
        viewModel.setCurentLanguage()
        var string = "CA DAO HAY VỀ CÁCH ĂN UỐNG"
        print(string.localizedCapitalized)
        string = string.unaccent().lowercased()
        let newString = string.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        print(newString)
        
        setupPicker()
    }
    
    private func setupUI() {
        let jeremyGif = UIImage.gifImageWithName("theForceOfTheStars")
        let imageView = UIImageView(image: jeremyGif)
        backgroundView.layout(imageView)
            .top().left().bottom().right()
    }
    
    // MARK: - Actions
    @IBAction func vietnamClicked(_ sender: Any) {
        viewModel.setLanguage(languageKey: .vietnamese)
    }
    
    @IBAction func englishClicked(_ sender: Any) {
        viewModel.setLanguage(languageKey: .english)
    }
    
    private func login() {
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
        login()
    }
}

extension LoginViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func setupPicker() {
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // set the picker to the middle of the long list
        pickerView.selectRow(viewModel.pickerDataSize/2, inComponent: 0, animated: false)
        pickerView.selectRow(viewModel.pickerDataSize/2, inComponent: 1, animated: false)
        pickerView.selectRow(viewModel.pickerDataSize/2, inComponent: 2, animated: false)
        pickerView.selectRow(viewModel.pickerDataSize/2, inComponent: 3, animated: false)
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(row % 10)
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        viewModel.password[component] = [row % 10]
        // do something with the resulting selected row
        
        // reset the picker to the middle of the long list
        let position = viewModel.pickerDataSize/2 + row
        pickerView.selectRow(position, inComponent: 0, animated: false)
    }
    
    // columns count
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel.dataSource.count
    }
    
    // rows count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.pickerDataSize
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        if let bold = PlayfairDisplayFont.bold(with: 20) {
            pickerLabel.font = bold
            pickerLabel.textAlignment = .center
            pickerLabel.textColor = UIColor.white
        }
        pickerLabel.text = "\(viewModel.dataSource[component][row % 10])"
        return pickerLabel
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(row % 10)
//    }
}

extension LoginViewController: LoginViewModelDelegate {
    func verifySuccess() {
        login()
    }
}
