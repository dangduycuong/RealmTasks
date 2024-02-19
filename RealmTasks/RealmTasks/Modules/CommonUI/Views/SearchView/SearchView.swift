//
//  SearchView.swift
//  RealmTasks
//
//  Created by cuongdd on 28/04/2022.
//

import UIKit

class SearchView: UIView {

    // MARK: - Outlets
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
                .foregroundColor: UIColor.random,
                .paragraphStyle: paragraphStyle,
            ]
            let attributedPlaceholder = NSAttributedString(string: R.string.localizable.enterSearchText().language(), attributes: attributes)
            searchTextField.attributedPlaceholder = attributedPlaceholder
        }
    }
    
    
    var searchText: ((String) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        initSubviews()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initSubviews()
        contentView?.prepareForInterfaceBuilder()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = false
        layer.cornerRadius = 10
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
    }

}

// MARK: Private funcs
extension SearchView {

    func initSubviews() {
        super.backgroundColor = .clear
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .clear
        self.subviews.forEach { view in
            view.removeFromSuperview()
        }
        addSubview(view)

        contentView = view
        contentView.backgroundColor = .black
        
//        contentView.clipsToBounds = true
        
        
        contentView.layer.shadowColor = UIColor.random.cgColor
        contentView.layer.shadowOpacity = 0.35
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 2
        
        contentView.layer.cornerRadius = 16
    }

}

extension SearchView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = searchTextField.text {
            searchText?(text)
        }
    }
}
