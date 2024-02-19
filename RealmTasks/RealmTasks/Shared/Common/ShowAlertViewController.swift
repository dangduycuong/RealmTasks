//
//  ShowAlertViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 22/04/2022.
//

import UIKit

class ShowAlertViewController: UIViewController {
    @IBOutlet weak var titleAlertLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var widthContentView: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var heightBackgroundImageView: NSLayoutConstraint!
    var alertType = AlertType.notice
    var titleAlert: String?
    var message: String = ""
    var titleLeftButton: String?
    var titleRightButton: String?
    var leftAction: (()->())?
    var rightAction: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.heightBackgroundImageView.constant = self.contentView.bounds.size.height
        backgroundImageView.layer.cornerRadius = 10
        backgroundImageView.layoutIfNeeded()
        
        view.backgroundColor = UIColor.random.withAlphaComponent(0.4)
        contentView.layer.shadowColor = UIColor.random.cgColor
        contentView.layer.shadowOpacity = 0.35
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 2
        contentView.layer.cornerRadius = 10
    }
    
    private func setupUI() {
        let bold = PlayfairDisplayFont.bold(with: 20) //for button
        let semiBold = PlayfairDisplayFont.semiBold(with: 20) //for title
        let regular = PlayfairDisplayFont.regular(with: 20) //for message
        
        let width = UIScreen.main.bounds.width
        if width <= 375 {
            widthContentView.constant = (359 * width) / 375
        } else {
            widthContentView.constant = 375
        }
        
        if let titleAlert = titleAlert {
            titleAlertLabel.font = semiBold
            titleAlertLabel.textColor = AppColor.blueCustom
            titleAlertLabel.text = titleAlert
        } else {
            titleAlertLabel.isHidden = true
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        paragraphStyle.lineBreakMode = .byTruncatingTail
        let attribuild = NSMutableAttributedString(
            string: self.message,
            attributes: [
                .font : regular!,
                .paragraphStyle: paragraphStyle
            ])
        messageLabel.attributedText = attribuild
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor.random
        
        if let titleLeftButton = titleLeftButton {
            leftButton.setTitle(titleLeftButton, for: .normal)
            leftButton.setTitleColor(UIColor.random, for: .normal)
            leftButton.titleLabel?.font = bold!
        } else {
            leftButton.isHidden = true
        }
        
        rightButton.setTitle(titleRightButton, for: .normal)
        rightButton.setTitleColor(UIColor.random, for: .normal)
        rightButton.titleLabel?.font = regular
        rightButton.backgroundColor = UIColor.random
        rightButton.layer.shadowColor = UIColor.random.cgColor
        rightButton.layer.shadowOpacity = 0.35
        rightButton.layer.shadowOffset = .zero
        rightButton.layer.shadowRadius = 2
        rightButton.layer.cornerRadius = 16
    }
    
    deinit {
        
    }
    
    // MARK: - Action
    @IBAction func leftButtonClicked(_ sender: Any) {
        dismiss(animated: false, completion: leftAction)
    }
    
    @IBAction func rightButtonClicked(_ sender: Any) {
        dismiss(animated: false, completion: rightAction)
    }
    
}

