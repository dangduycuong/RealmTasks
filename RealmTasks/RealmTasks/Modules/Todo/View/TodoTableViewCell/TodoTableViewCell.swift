//
//  TodoTableViewCell.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

protocol TodoTableViewCellDelegate: AnyObject {
    func modifyTodoStatus(indexPath: IndexPath)
}

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var heightBackGroundImageView: NSLayoutConstraint!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoDescriptionLabel: UILabel!
    
    var indexPath: IndexPath?
    weak var delegate: TodoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        checkboxButton.setTitle("", for: .normal)
        checkboxButton.tintColor = AppColor.blueCustom
        
        subView.layer.shadowColor = UIColor.random.cgColor
        subView.layer.shadowOpacity = 0.35
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 2
        
        subView.layer.cornerRadius = 8
        subView.backgroundColor = UIColor.random
        
        backgroundImageView.layer.cornerRadius = 8
    }
    
    func fillData(todo: TodoModel, colorCell: UIColor, searchText: String?) {
        checkboxImageView.image = todo.isCompleted ? R.image.icons8Checked_checkbox()?.withRenderingMode(.alwaysTemplate) : R.image.icons8Unchecked_checkbox()?.withRenderingMode(.alwaysTemplate)
        checkboxImageView.tintColor = colorCell
        
        DispatchQueue.main.async {
            self.heightBackGroundImageView.constant = self.stackView.bounds.size.height + 8
        }
        let bold = R.font.playfairDisplayBold(size: 20)
        let medium = R.font.playfairDisplayMedium(size: 20)
        hilightText(searchText: searchText, content: todo.todoTitle, label: todoTitleLabel, font: bold, color: colorCell)
        hilightText(searchText: searchText, content: todo.todoDescription, label: todoDescriptionLabel, font: medium, color: colorCell)
    }
    
    private func hilightText(searchText: String?, content: String?, label: UILabel, font: UIFont?, color: UIColor) {
        guard let content = content else { return }
        guard let keyWord = searchText else { return }
        let rangeContent = findRange(source: content , textToFind: keyWord.folded.lowercased())
        if rangeContent.location != NSNotFound {
            setColorTextLabel(string: content, range: rangeContent, label: label, color: color, font: font)
        } else {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.alignment = .left
            let attributes: [NSAttributedString.Key : Any] = [
                .font: font as Any,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: color
            ]
            
            label.attributedText = NSAttributedString(string: content, attributes: attributes)
        }
    }
    
    func findRange(source: String, textToFind: String) -> NSRange {
        let string = NSMutableAttributedString(string: source.folded.lowercased())
        
        let range = string.mutableString.range(of: textToFind.folded.lowercased(), options: .caseInsensitive)
        return range
    }
    
    func setColorTextLabel(string: String, range: NSRange, label: UILabel, color: UIColor, font: UIFont?) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 6
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font as Any,
            .foregroundColor: color
        ]
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: string, attributes: attributes)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: range)
        label.attributedText = myMutableString
    }
    
    @IBAction func checkboxButtonClicked(_ sender: Any) {
        if let delegate = delegate, let indexPath = indexPath {
            delegate.modifyTodoStatus(indexPath: indexPath)
        }
    }
}
