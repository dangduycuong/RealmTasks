//
//  SegmentedControlView.swift
//  RealmTasks
//
//  Created by cuongdd on 8/2/25.
//

import UIKit
import Material

class SegmentedControlView: UIView {
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.addTarget(self, action: #selector(segmentedControlClicked), for: .valueChanged)
        return segmentedControl
    }()
    
    private var items: [String] = []
    
    var indexValueChanged: ((Int) -> Void) = { _ in }
    var selectedSegmentIndex: Int = 0
    
    init(items: [String], frame: CGRect) {
        self.items = items
        super.init(frame: frame)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white.withAlphaComponent(0.4) // Set the background color
        
        self.layout(segmentedControl)
            .top()
            .left()
            .bottom()
            .right()
        
        segmentedControl.removeAllSegments()
        for i in 0..<items.count {
            let item = items[i]
            segmentedControl.insertSegment(withTitle: item, at: i, animated: true)
        }
        segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        
        if let bold = PlayfairDisplayFont.bold(with: 20) {
            let titleNormalAttributes = [
                NSAttributedString.Key.font: bold,
                NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.4)
            ]
            let titleSelectedAttributes = [
                NSAttributedString.Key.font: bold,
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            segmentedControl.setTitleTextAttributes(titleNormalAttributes, for: .normal)
            segmentedControl.setTitleTextAttributes(titleSelectedAttributes, for: .selected)
            segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            segmentedControl.selectedSegmentTintColor = UIColor.white
        }
        self.layer.cornerRadius = 6
    }
    
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        indexValueChanged(selectedSegmentIndex)
    }
}
