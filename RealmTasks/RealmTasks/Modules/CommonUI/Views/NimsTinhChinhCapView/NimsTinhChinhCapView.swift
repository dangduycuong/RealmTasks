//
//  NimsTinhChinhCapView.swift
//  RealmTasks
//
//  Created by cuongdd on 16/02/2024.
//

import UIKit

class NimsTinhChinhCapView: UIView {
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            let italic = PlayfairDisplayFont.italic(with: 20)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.alignment = .left
            paragraphStyle.lineHeightMultiple = 1
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: italic as Any,
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle,
            ]
            let attributedPlaceholder = NSAttributedString(string: R.string.localizable.enterSearchText().language(), attributes: attributes)
            searchTextField.attributedPlaceholder = attributedPlaceholder
        }
    }
    
    var searchText: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchTextField.delegate = self
        searchTextField.textColor = UIColor.black
        searchTextField.tintColor = UIColor.black
        searchTextField.font = R.font.playfairDisplayMedium(size: 20)
        contentView.layer.cornerRadius = 6
        searchTextField.clearButtonMode = .whileEditing
    }
    
}

extension NimsTinhChinhCapView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchText?(textField.text ?? "")
    }
}
