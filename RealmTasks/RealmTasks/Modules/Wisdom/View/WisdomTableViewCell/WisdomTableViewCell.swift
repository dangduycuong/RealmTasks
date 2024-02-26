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
    
    func fillData(content: String, keyWord: String, colorCell: UIColor) {
        let medium = R.font.playfairDisplayMedium(size: 20)
        hilightText(searchText: keyWord, content: content, label: contentLabel, color: colorCell, font: medium)
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
