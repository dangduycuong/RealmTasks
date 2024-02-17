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
    
    func fillData(content: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 6
        let attributes: [NSAttributedString.Key: Any] = [
            .font: R.font.playfairDisplayMedium(size: 20) as Any,
            .foregroundColor: UIColor(hexString: "4B5320"),
            .paragraphStyle: paragraphStyle
        ]
        contentLabel.attributedText = NSAttributedString(string: content, attributes: attributes)
    }
    
}
