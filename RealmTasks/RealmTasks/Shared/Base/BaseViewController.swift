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
    
    lazy var backGroundImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.woodGrain3())
        return imageView
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
        backButton.removeFromSuperview()
        backButton.addTarget(self, action: #selector(backButtonClicked(sender:)), for: .touchUpInside)
        view.layout(backButton)
            .left(0).topSafe(16).width(44).height(44)
        
        let backImageView = UIImageView(image: UIImage(named: "left-arrow"))
        view.layout(backImageView)
            .left(16).centerY(titleLabel).width(24).height(24)
    }
    
    func addTitle(title: String) {
        if let extraBold = PlayfairDisplayFont.extraBold(with: 20) {
            titleLabel.text = title
            titleLabel.font = extraBold
            titleLabel.textColor = UIColor.white
            view.layout(titleLabel)
                .centerX().topSafe(16)
        }
    }
    
    func addBackground() {
        view.layout(backGroundImageView)
            .top().left().bottom().right()
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
