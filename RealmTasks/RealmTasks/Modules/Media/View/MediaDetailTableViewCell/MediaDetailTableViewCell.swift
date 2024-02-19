//
//  MediaDetailTableViewCell.swift
//  RealmTasks
//
//  Created by cuongdd on 25/04/2022.
//

import UIKit

protocol MediaDetailTableViewCellDelegate: AnyObject {
    func favoriteChange(cell: UITableViewCell)
}

class MediaDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: MediaDetailTableViewCellDelegate?
    
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
        subView.backgroundColor = UIColor.random.withAlphaComponent(0.4)
        
        favoriteButton.setTitle("", for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func fillData(data: MediaDetailDisplay, keyWord: String) {
        selectionStyle = .none
        let rangeContent = findRange(source: data.content.folded.lowercased(), textToFind: keyWord.folded.lowercased())
        if rangeContent.location != NSNotFound {
            setColorTextLabel(string: data.content, range: rangeContent, label: messageLabel)
        } else {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            paragraphStyle.lineSpacing = 6
            let attributes: [NSAttributedString.Key: Any] = [
                .font: R.font.playfairDisplayMedium(size: 20) as Any,
                .foregroundColor: UIColor.random,
                .paragraphStyle: paragraphStyle
            ]
            messageLabel.attributedText = NSAttributedString(string: data.content, attributes: attributes)
        }
        
        favoriteImageView.image = data.isFavorite ? R.image.icons8Heart_suit() : R.image.icons8Favorite()
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
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        delegate?.favoriteChange(cell: self)
    }
}
