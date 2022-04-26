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
    
    @IBOutlet weak var heightBackgroundImageView: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subView.layer.shadowColor = UIColor.white.cgColor
        subView.layer.shadowOpacity = 0.35
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 2
        
        subView.layer.cornerRadius = 8
        subView.backgroundColor = AppColor.blueCustom
        favoriteButton.setTitle("", for: .normal)
        backgroundImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(data: MediaDisplayList) {
        messageLabel.text = data.content
        
        favoriteImageView.image = data.isFavorite ? R.image.icons8Heart_suit() : R.image.icons8Favorite()
        
        print("chieu cao\n",
              "subView",subView.bounds.size.height,
        "\nmessageLabel", messageLabel.bounds.size.height,
              "\nheightBackgroundImageView.constant", heightBackgroundImageView.constant, backgroundImageView.bounds.size.height)
        DispatchQueue.main.async {
            self.heightBackgroundImageView.constant = self.messageLabel.bounds.size.height + 8
        }
        backgroundImageView.layoutIfNeeded()
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        delegate?.favoriteChange(cell: self)
    }
    
    
}
