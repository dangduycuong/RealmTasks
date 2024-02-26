//
//  MediaTableViewCell.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        subView.layer.shadowColor = UIColor.random.cgColor
        subView.layer.shadowOpacity = 0.35
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 2
        subView.layer.cornerRadius = 8
        subView.backgroundColor = AppColor.blueCustom
        
        backgroundImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(title: String?, searchText: String?, colorCell: UIColor) {
        hilightText(searchText: searchText, content: title, colorCell: colorCell, label: titleLabel)
    }
    
    private func hilightText(searchText: String?, content: String?, colorCell: UIColor, label: UILabel) {
        guard let content = content else { return }
        guard let keyWord = searchText else { return }
        let rangeContent = findRange(source: content , textToFind: keyWord.folded.lowercased())
        if rangeContent.location != NSNotFound {
            setColorTextLabel(string: content, range: rangeContent, label: label)
        } else {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.alignment = .left
            let attributes: [NSAttributedString.Key : Any] = [
                .font: R.font.playfairDisplayMedium(size: 20) as Any,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: colorCell
            ]
            
            label.attributedText = NSAttributedString(string: content, attributes: attributes)
        }
    }
    
    func findRange(source: String, textToFind: String) -> NSRange {
        let string = NSMutableAttributedString(string: source.folded.lowercased())
        
        let range = string.mutableString.range(of: textToFind.folded.lowercased(), options: .caseInsensitive)
        return range
    }
    
    func setColorTextLabel(string: String, range: NSRange, label: UILabel) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 6
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: R.font.playfairDisplayMedium(size: 20) as Any
        ]
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: string, attributes: attributes)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: range)
        label.attributedText = myMutableString
    }
    
}
