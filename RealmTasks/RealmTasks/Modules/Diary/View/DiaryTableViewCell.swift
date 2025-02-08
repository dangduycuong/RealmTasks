//
//  DiaryTableViewCell.swift
//  RealmTasks
//
//  Created by cuongdd on 20/02/2024.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let containerView = UIView()
    // Custom properties for your cell's UI elements
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Initialize UI elements and add them to the cell's content view
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize UI elements and add them to the cell's content view
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        // Add UI elements to the cell's content view
        self.layout(containerView)
            .top()
            .left(16)
            .bottom(16)
            .right(16)
        
        containerView.layer.cornerRadius = 4
        
        containerView.layout(titleLabel)
            .top(8)
            .left(8)
        
        containerView.layout(descriptionLabel)
            .below(titleLabel, 8)
            .left(8)
            .bottom(8)
            .right(8)
        
        titleLabel.font = R.font.playfairDisplayBold(size: 20)
        descriptionLabel.font = R.font.playfairDisplayMedium(size: 20)
    }
    
    // MARK: - Configure Cell
    
    func configure(title: String, description: String, searchText: String?) {
        hilightText(searchText: searchText, content: title, label: titleLabel)
        hilightText(searchText: searchText, content: description, label: descriptionLabel)
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
    }
}
