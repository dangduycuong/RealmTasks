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
    
    func setupUI() {
        let menloBoldItalic = MenloFont.boldItalic(with: 18)
        let menloBold = MenloFont.bold(with: 18)
        let menloItalic = MenloFont.italic(with: 16)
        let menloRegular = MenloFont.regular(with: 16)
        
        let width = UIScreen.main.bounds.width
        if width <= 375 {
            widthContentView.constant = (359 * width) / 375
        } else {
            widthContentView.constant = 375
        }
        
        if let titleAlert = titleAlert {
            titleAlertLabel.font = menloBold
            titleAlertLabel.textColor = AppColor.blueCustom
            titleAlertLabel.text = titleAlert
        } else {
            titleAlertLabel.isHidden = true
        }
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        paragraphStyle.lineBreakMode = .byTruncatingTail
        let attribuild = NSMutableAttributedString(
            string: self.message,
            attributes: [
                .font : menloRegular!,
                .paragraphStyle: paragraphStyle
            ])
        messageLabel.attributedText = attribuild
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = AppColor.blueCustom
        
        if let titleLeftButton = titleLeftButton {
            leftButton.setTitle(titleLeftButton, for: .normal)
            leftButton.setTitleColor(AppColor.blueCustom, for: .normal)
            leftButton.layer.cornerRadius = 16
            leftButton.titleLabel?.font = menloBold!
        } else {
            leftButton.isHidden = true
        }
        
        
        rightButton.setTitle(titleRightButton, for: .normal)
        rightButton.setTitleColor(.white, for: .normal)
        rightButton.backgroundColor = AppColor.blueCustom
        rightButton.layer.cornerRadius = 16
        rightButton.titleLabel?.font = menloRegular
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

