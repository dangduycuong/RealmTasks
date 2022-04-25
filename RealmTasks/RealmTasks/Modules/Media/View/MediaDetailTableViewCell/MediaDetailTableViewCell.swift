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
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: MediaDetailTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOpacity = 0.35
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 2
        
        subView.layer.cornerRadius = 8
        subView.backgroundColor = AppColor.blueCustom
        favoriteButton.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(text: String) {
        messageLabel.text = text
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        delegate?.favoriteChange(cell: self)
    }
    
    
}
