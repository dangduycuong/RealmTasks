//
//  BaseViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit
import Material

class BaseViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    var backButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    var spinner = UIActivityIndicatorView(style: .large)
    let alertService = AlertService()
    
    func setupIndicatorView() {
        view.layout(spinner)
            .center()
        spinner.tintColor = AppColor.blueCustom
        spinner.color = AppColor.blueCustom
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    func removeBorderNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func addBackButton() {
        backButton.addTarget(self, action: #selector(backButtonClicked(sender:)), for: .touchUpInside)
        view.layout(backButton)
            .left(16).topSafe().width(44).height(44)
        
        let backImageView = UIImageView(image: UIImage(named: "arrowBack"))
        backButton.backgroundColor = UIColor.black
    }
    
    func addTitle(title: String) {
        if let extraBold = PlayfairDisplayFont.extraBold(with: 20) {
            titleLabel.text = title
            titleLabel.font = extraBold
            titleLabel.textColor = UIColor.white
            view.layout(titleLabel)
                .centerX().topSafe()
        }
    }
    
    @objc func backButtonClicked(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(type: AlertType, titleAlert: String? = nil, message: String, titleLeftButton: String? = nil, titleRightButton: String? = nil, leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) {
        let vc = alertService.showAlert(type: type, titleAlert: titleAlert, message: message, titleLeftButton: titleLeftButton, titleRightButton: titleRightButton, leftAction: leftAction, rightAction: rightAction)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: false, completion: nil)
    }
    
}
