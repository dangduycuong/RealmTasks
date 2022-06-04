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
        contentLabel.text = content
    }
    
}
