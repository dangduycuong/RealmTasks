//
//  WeatherTableViewCell.swift
//  RealmTasks
//
//  Created by cuongdd on 25/02/2024.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let containerView = UIView()
    
    // Custom properties for your cell's UI elements
    let titleLabel = UILabel()
    
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
        backgroundColor = .clear
        selectionStyle = .none
        self.layout(containerView)
            .top()
            .left(16)
            .bottom(16)
            .right(16)
        
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        titleLabel.numberOfLines = 0
        containerView.layout(titleLabel)
            .top(8)
            .left(8)
            .bottom(8)
            .right(8)
    }
    
    // MARK: - Configure Cell
    
    func fillData(content: String?, isShowing: Bool?, searchText: String?, color: UIColor) {
        containerView.backgroundColor = isShowing == true ? UIColor.white : UIColor.white.withAlphaComponent(0.4)
        
        hilightText(searchText: searchText, content: content, label: titleLabel, color: color, font: R.font.playfairDisplayMedium(size: 20))
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

