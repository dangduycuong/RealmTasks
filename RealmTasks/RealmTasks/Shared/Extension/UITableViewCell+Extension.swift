//
//  UITableViewCell+Extension.swift
//  RealmTasks
//
//  Created by cuongdd on 8/2/25.
//

import UIKit

// MARK: - UITableViewCell Hilight Text
extension UITableViewCell {
    func hilightText(searchText: String?, content: String?, label: UILabel) {
        let hilightColor = UIColor.red
        let hilightFont = R.font.playfairDisplayBold(size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        let normalColor = UIColor.black
        let normalFont = R.font.playfairDisplayMedium(size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .medium)
        guard let content = content else { return }
        guard let keyWord = searchText else { return }
        let rangeContent = findRange(source: content , textToFind: keyWord.folded.lowercased())
        if rangeContent.location != NSNotFound {
            setColorTextLabel(string: content, range: rangeContent, label: label, normalColor: normalColor, normalFont: normalFont, hilightColor: hilightColor, hilightFont: hilightFont)
        } else {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.alignment = .left
            let attributes: [NSAttributedString.Key : Any] = [
                .font: normalFont,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: normalColor
            ]
            
            label.attributedText = NSAttributedString(string: content, attributes: attributes)
        }
    }
    
    private func findRange(source: String, textToFind: String) -> NSRange {
        let string = NSMutableAttributedString(string: source.folded.lowercased())
        
        let range = string.mutableString.range(of: textToFind.folded.lowercased(), options: .caseInsensitive)
        return range
    }
    
    private func setColorTextLabel(string: String, range: NSRange, label: UILabel, normalColor: UIColor, normalFont: UIFont, hilightColor: UIColor, hilightFont: UIFont) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 6
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: normalFont,
            .foregroundColor: normalColor
        ]
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: string, attributes: attributes)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: hilightColor, range: range)
        myMutableString.addAttribute(NSAttributedString.Key.font, value: hilightFont, range: range)
        label.attributedText = myMutableString
    }
}

