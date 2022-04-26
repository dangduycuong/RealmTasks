//
//  TodoTableViewCell.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

protocol TodoTableViewCellDelegate: AnyObject {
    func modifyTodoStatus(indexPath: IndexPath)
}

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var heightBackGroundImageView: NSLayoutConstraint!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoDescriptionLabel: UILabel!
    
    var indexPath: IndexPath?
    weak var delegate: TodoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        checkboxButton.setTitle("", for: .normal)
        checkboxButton.tintColor = AppColor.blueCustom
        
        subView.layer.shadowColor = UIColor.white.cgColor
        subView.layer.shadowOpacity = 0.35
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 2
        
        subView.layer.cornerRadius = 8
        subView.backgroundColor = AppColor.blueCustom
        
        backgroundImageView.layer.cornerRadius = 8
    }
    
    func fillData(todo: TodoModel) {
        checkboxImageView.image = todo.isCompleted ? R.image.icons8Checked_checkbox()?.withRenderingMode(.alwaysTemplate) : R.image.icons8Unchecked_checkbox()?.withRenderingMode(.alwaysTemplate)
        checkboxImageView.tintColor = AppColor.blueCustom
        todoTitleLabel.text = todo.todoTitle
        todoDescriptionLabel.text = todo.todoDescription
        DispatchQueue.main.async {
            self.heightBackGroundImageView.constant = self.stackView.bounds.size.height + 8
        }
    }
    
    @IBAction func checkboxButtonClicked(_ sender: Any) {
        if let delegate = delegate, let indexPath = indexPath {
            delegate.modifyTodoStatus(indexPath: indexPath)
        }
    }
}
