//
//  DiaryTableViewCell.swift
//  RealmTasks
//
//  Created by cuongdd on 20/02/2024.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let containerView = UIView()
    // Custom properties for your cell's UI elements
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Initialize UI elements and add them to the cell's content view
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize UI elements and add them to the cell's content view
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        // Add UI elements to the cell's content view
        self.layout(containerView)
            .top()
            .left(16)
            .bottom(16)
            .right(16)
        
        containerView.layer.cornerRadius = 4
        
        containerView.layout(titleLabel)
            .top(8)
            .left(8)
        
        containerView.layout(descriptionLabel)
            .below(titleLabel, 8)
            .left(8)
            .bottom(8)
            .right(8)
        
        titleLabel.font = R.font.playfairDisplayBold(size: 20)
        descriptionLabel.font = R.font.playfairDisplayMedium(size: 20)
    }
    
    // MARK: - Configure Cell
    
    func configure(title: String, description: String, searchText: String?, color: UIColor) {
        let bold = R.font.playfairDisplayBold(size: 20)
        let medium = R.font.playfairDisplayMedium(size: 20)
        
        hilightText(searchText: searchText, content: title, label: titleLabel, color: color, font: bold)
        hilightText(searchText: searchText, content: description, label: descriptionLabel, color: color, font: medium)
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
    }
    
    private func hilightText(searchText: String?, content: String?, label: UILabel, color: UIColor, font: UIFont?) {
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
}
