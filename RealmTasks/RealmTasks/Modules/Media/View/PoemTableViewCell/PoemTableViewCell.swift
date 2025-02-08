//
//  PoemTableViewCell.swift
//  RealmTasks
//
//  Created by cuongdd on 15/02/2024.
//

import UIKit

class PoemTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Custom properties for your cell's UI elements
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let noteLabel = UILabel()
    
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
        selectionStyle = .none
        backgroundColor = .clear
        // Add UI elements to the cell's content view
        
        // Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        // Description Label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        // Thumbnail Image View
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(noteLabel)
        NSLayoutConstraint.activate([
            noteLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    // MARK: - Configure Cell
    
    func configure(title: String, description: String, note: String?, keyWord: String?) {
        // Configure UI elements with data
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        noteLabel.numberOfLines = 0
        
        hilightText(searchText: keyWord, content: title, label: titleLabel)
        hilightText(searchText: keyWord, content: description, label: descriptionLabel)
        hilightText(searchText: keyWord, content: note, label: noteLabel)
    }
    
}
