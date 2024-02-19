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
    
    func configure(title: String, description: String, note: String?, keyWord: String) {
        
        // Configure UI elements with data
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        
        titleLabel.textColor = UIColor.random
        noteLabel.textColor = UIColor.random
        
        titleLabel.font = R.font.playfairDisplayBold(size: 20)
        descriptionLabel.font = R.font.playfairDisplayMedium(size: 20)
        noteLabel.font = R.font.playfairDisplaySemiBoldItalic(size: 20)
        noteLabel.numberOfLines = 0
        
        let rangeTitle = findRange(source: title.folded.lowercased(), textToFind: keyWord.folded.lowercased())
        if rangeTitle.location != NSNotFound {
            setColorTextLabel(string: title, range: rangeTitle, label: titleLabel)
        } else {
            titleLabel.text = title
        }
        
        let rangeContent = findRange(source: description.folded.lowercased(), textToFind: keyWord.folded.lowercased())
        if rangeContent.location != NSNotFound {
            setColorTextLabel(string: description, range: rangeContent, label: descriptionLabel)
        } else {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            paragraphStyle.lineSpacing = 6
            let attributes: [NSAttributedString.Key: Any] = [
                .font: R.font.playfairDisplayMedium(size: 20) as Any,
                .foregroundColor: UIColor.random,
                .paragraphStyle: paragraphStyle
            ]
            descriptionLabel.attributedText = NSAttributedString(string: description, attributes: attributes)
        }
        
        let rangeNote = findRange(source: note ?? "".folded.lowercased(), textToFind: keyWord.folded.lowercased())
        if rangeNote.location != NSNotFound {
            setColorTextLabel(string: description, range: rangeNote, label: noteLabel)
        } else {
            noteLabel.text = note
        }
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
    
}
