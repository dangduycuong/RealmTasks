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
        subView.layer.shadowColor = UIColor.white.cgColor
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
    
    func fillData(title: String?) {
//        iconImageView.image = R.image.bakery()
        titleLabel.text = title
    }
    
}
