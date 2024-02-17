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
        view.backgroundColor = UIColor(hexString: "008080")
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
    
    private var titles: [String] = ["1", "2", "3"]
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
        
        setupUI()
    }
    
    private func setupUI() {
        self.layout(containerView)
            .top().left().bottom().right()
        
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = UIColor(hexString: "1282A0")
        
        containerView.layout(stackView)
            .top(2).left(2).bottom(2).right(2)
        
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
        UIView.animate(withDuration: 0.35) {
            for i in 0..<self.titles.count {
                if i == selectedSegmentIndex {
                    self.selectedSubViews[i].backgroundColor = UIColor.white.withAlphaComponent(0.4)
                    self.selectedSubViews[i].layer.borderColor = UIColor(hexString: "B42569").cgColor
                    self.selectedLabels[i].textColor = UIColor(hexString: "B42569")
                } else {
                    self.selectedSubViews[i].backgroundColor = UIColor.clear
                    self.selectedSubViews[i].layer.borderColor = UIColor.clear.cgColor
                    self.selectedLabels[i].textColor = UIColor.white.withAlphaComponent(0.4)
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
    
    @objc private func segmentControlValueChanged(_ sender: UIButton) {
        updateUI(sender.tag)
    }
}

