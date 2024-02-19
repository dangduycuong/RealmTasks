//
//  WisdomTableViewCell.swift
//  RealmTasks
//
//  Created by cuongdd on 07/05/2022.
//

import UIKit

class WisdomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func fillData(content: String, keyWord: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 6
        let attributes: [NSAttributedString.Key: Any] = [
            .font: R.font.playfairDisplayMedium(size: 20) as Any,
            .foregroundColor: UIColor.random,
            .paragraphStyle: paragraphStyle
        ]
        contentLabel.attributedText = NSAttributedString(string: content, attributes: attributes)
        
        
        let rangeContent = findRange(source: content.folded.lowercased(), textToFind: keyWord.folded.lowercased())
        if rangeContent.location != NSNotFound {
            setColorTextLabel(string: content, range: rangeContent, label: contentLabel)
        } else {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            paragraphStyle.lineSpacing = 6
            let attributes: [NSAttributedString.Key: Any] = [
                .font: R.font.playfairDisplayMedium(size: 20) as Any,
                .foregroundColor: UIColor.random,
                .paragraphStyle: paragraphStyle
            ]
            contentLabel.attributedText = NSAttributedString(string: content, attributes: attributes)
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
            .paragraphStyle: paragraphStyle
        ]
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: string, attributes: attributes)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: range)
        label.attributedText = myMutableString
    }
    
}
