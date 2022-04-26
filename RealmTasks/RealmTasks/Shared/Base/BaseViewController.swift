//
//  BaseViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit
import Material

class BaseViewController: UIViewController {
    
    var backButton: UIButton = {
        let originalImage = R.image.icons8Back()
        let tintedImage = originalImage!.withRenderingMode(.alwaysTemplate)
        let button = IconButton(image: tintedImage, tintColor: .white)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 11, right: 0)
        button.contentHorizontalAlignment = .left
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
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    @objc func backButtonClicked(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(type: AlertType, titleAlert: String?, message: String, titleLeftButton: String?, titleRightButton: String?, leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) {
        let vc = alertService.showAlert(type: type, titleAlert: titleAlert, message: message, titleLeftButton: titleLeftButton, titleRightButton: titleRightButton, leftAction: leftAction, rightAction: rightAction)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: false, completion: nil)
    }
    
}
