//
//  BaseViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit
import Material
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextDetail), for: .touchUpInside)
        return button
    }()
    
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
    
    func setupAddDataButton(color: UIColor? = UIColor.random) {
        let addView = UIView()
        let addImageView = UIImageView()
        
        view.layout(addView)
            .right(16)
            .bottomSafe(16)
            .width(40)
            .height(40)
        
        addView.layout(addImageView)
            .center()
            .width(40)
            .height(40)
        addView.layout(addButton)
            .top()
            .left()
            .bottom()
            .right()
        
        addImageView.image = R.image.add()?.withRenderingMode(.alwaysTemplate)
        addImageView.tintColor = color
        
        addView.layer.cornerRadius = 20
        addView.layer.shadowColor = UIColor.black.cgColor
        addView.layer.shadowOpacity = 0.75
        addView.layer.shadowOffset = .zero
        addView.layer.shadowRadius = 8
    }
    
    @objc func nextDetail(_ sender: UIButton) {
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
    
    func addBackButton(color: UIColor? = UIColor.random) {
        backButton.removeFromSuperview()
        backButton.addTarget(self, action: #selector(backButtonClicked(sender:)), for: .touchUpInside)
        view.layout(backButton)
            .left(0).centerY(titleLabel).width(44).height(44)
        
        let backImage = UIImage(named: "left-arrow")?.withRenderingMode(.alwaysTemplate)
        let backImageView = UIImageView(image: backImage)
        backImageView.tintColor = color
        backButton.layout(backImageView)
            .left(16).centerY(titleLabel).width(24).height(24)
    }
    
    func addTitle(title: String, color: UIColor? = UIColor.random) {
        if let extraBold = PlayfairDisplayFont.extraBold(with: 20) {
            titleLabel.text = title
            titleLabel.font = extraBold
            titleLabel.textColor = color
            view.layout(titleLabel)
                .centerX().topSafe(8)
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
