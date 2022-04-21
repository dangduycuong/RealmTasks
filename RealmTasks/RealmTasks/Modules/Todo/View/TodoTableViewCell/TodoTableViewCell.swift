//
//  TodoTableViewCell.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoDescriptionLabel: UILabel!
    
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
        
    }
    
    func fillData(todo: TodoModel) {
        checkboxImageView.image = todo.isCompleted ? R.image.icons8Checked_checkbox()?.withRenderingMode(.alwaysTemplate) : R.image.icons8Unchecked_checkbox()?.withRenderingMode(.alwaysTemplate)
        checkboxImageView.tintColor = AppColor.blueCustom
        todoTitleLabel.text = todo.todoTitle
        todoDescriptionLabel.text = todo.todoDescription
    }
    
    @IBAction func checkboxButtonClicked(_ sender: Any) {
    }
}
