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
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOpacity = 0.35
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 2
        subView.layer.cornerRadius = 8
        
        favoriteButton.setTitle("", for: .normal)
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func fillData(data: MediaDetailDisplay, searchText: String?) {
        subView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        hilightText(searchText: searchText, content: data.content, label: messageLabel)
        favoriteImageView.image = data.isFavorite ? R.image.icons8Heart_suit() : R.image.icons8Favorite()
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        delegate?.favoriteChange(cell: self)
    }
}
