//
//  CustomSegmentedControlView.swift
//  RealmTasks
//
//  Created by cuongdd on 17/02/2024.
//

import UIKit

class CustomSegmentedControlView: UIView {
    lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    var selectedSubViews = [UIView]()
    var selectedLabels = [UILabel]()
    var selectedButtons = [UIButton]()
    
    var mainColor: UIColor = UIColor.random
    
    private var titles: [String] = ["1", "2", "3"]
    var segmentedControlValue: ((Int) -> Void) = { _ in }
    // Add any custom properties
    
    // Example custom property
    var customColor: UIColor = .red {
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
        
        setupUI()
    }
    
    private func setupUI() {
        self.layout(containerView)
            .top().left().bottom().right()
        
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = UIColor.random
        
        containerView.layout(stackView)
            .top().left().bottom().right()
        
        for i in 0..<titles.count {
            let view = UIView()
            let titleLabel = UILabel()
            titleLabel.font = R.font.playfairDisplayMedium(size: 20)
            let button = UIButton()
            view.layout(titleLabel)
                .center()
            view.layout(button)
                .top().left().bottom().right()
            button.tag = i
            button.addTarget(self, action: #selector(segmentControlValueChanged), for: .touchUpInside)
            titleLabel.text = titles[i]
            stackView.addArrangedSubview(view)
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 10
            selectedSubViews.append(view)
            selectedLabels.append(titleLabel)
            selectedButtons.append(button)
        }
        updateUI(1)
    }
    
    // Override draw method for custom drawing (if needed)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Custom drawing code
    }
    
    private func updateUI(_ selectedSegmentIndex: Int) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = .center
        
        let attributesSelected: [NSAttributedString.Key : Any] = [
            .font: R.font.playfairDisplayBold(size: 20) as Any,
            .foregroundColor: mainColor,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributesNormal: [NSAttributedString.Key : Any] = [
            .font: R.font.playfairDisplayMedium(size: 20) as Any,
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]
        
        UIView.animate(withDuration: 0.35) {
            for i in 0..<self.titles.count {
                if i == selectedSegmentIndex {
                    self.selectedSubViews[i].backgroundColor = UIColor.white
                    self.selectedSubViews[i].layer.borderColor = self.mainColor.cgColor
                    self.selectedLabels[i].attributedText = NSAttributedString(string: self.titles[i], attributes: attributesSelected)
                } else {
                    self.selectedSubViews[i].backgroundColor = UIColor.clear
                    self.selectedSubViews[i].layer.borderColor = UIColor.clear.cgColor
                    self.selectedLabels[i].attributedText = NSAttributedString(string: self.titles[i], attributes: attributesNormal)
                }
            }
        }
    }
    
    func setNewValue(_ titles: [String]) {
        self.titles = titles
        
        containerView.removeFromSuperview()
        
        containerView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        stackView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        selectedSubViews.forEach { view in
            view.removeFromSuperview()
        }
        
        selectedLabels.forEach { label in
            label.removeFromSuperview()
        }
        
        selectedButtons.forEach { button in
            button.removeFromSuperview()
        }
        
        selectedSubViews.removeAll()
        selectedLabels.removeAll()
        selectedButtons.removeAll()
        setupUI()
    }
    
    func setDefaultValue(_ value: Int) {
        updateUI(value)
    }
    
    func updateColor(_ color: UIColor) {
        mainColor = color
        containerView.backgroundColor = color.withAlphaComponent(0.4)
    }
    
    @objc private func segmentControlValueChanged(_ sender: UIButton) {
        updateUI(sender.tag)
        segmentedControlValue(sender.tag)
    }
}

