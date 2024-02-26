//
//  ExplainContentView.swift
//  RealmTasks
//
//  Created by cuongdd on 25/02/2024.
//

import UIKit

class ExplainContentView: UIView {
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    // Add any custom properties
    
    // Example custom property
    var customColor: UIColor = .blue {
        didSet {
            // Call setNeedsDisplay to update the view when the property changes
            setNeedsDisplay()
        }
    }
    
    // Override the initializer methods as needed
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom initialization code
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Custom initialization code
        setupView()
    }
    
    // Setup view properties or add subviews here
    private func setupView() {
        self.layout(containerView)
            .top()
            .left()
            .bottom()
            .right()
        
        containerView.layer.cornerRadius = 4
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 4
        containerView.backgroundColor = UIColor.white
        
        containerView.layout(contentLabel)
            .top(8)
            .left(8)
            .bottom(8)
            .right(8)
    }
    
    // Override draw method for custom drawing (if needed)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Custom drawing code
    }
    
    func fillData(_ content: String?) {
        guard let content = content else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = .left
        let attributes: [NSAttributedString.Key : Any] = [
            .font: R.font.playfairDisplayMedium(size: 20) as Any,
            .paragraphStyle: paragraphStyle
        ]
        contentLabel.numberOfLines = 0
        contentLabel.attributedText = NSAttributedString(string: content, attributes: attributes)
    }
}
