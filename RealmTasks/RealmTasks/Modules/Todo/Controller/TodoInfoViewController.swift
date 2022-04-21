//
//  TodoInfoViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit
import Material

class TodoInfoViewController: BaseViewController {
    
    @IBOutlet weak var todoTitleTextField: UITextField!
    @IBOutlet weak var todoDescriptionTextView: UITextView!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var checkboxImageView: UIImageView!
    
    var rightButton: UIButton = {
        let originalImage = R.image.icons8Save()
        let tintedImage = originalImage!.withRenderingMode(.alwaysTemplate)
        let button = IconButton(image: nil, tintColor: AppColor.blueCustom)
        button.setBackgroundImage(tintedImage, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    var placeholderLabel : UILabel!
    
    var viewModel = TodoInfoViewModel()
    var todo: TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillData()
    }
    
    private func setupUI() {
        
        rightButton.addTarget(self, action: #selector(saveTodo), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        addBackButton()
        title = "Todo Detail"
        checkboxButton.setTitle("", for: .normal)
        placeholderLabel = UILabel()
        placeholderLabel.text = "Enter some text..."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (todoDescriptionTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        todoDescriptionTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (todoDescriptionTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !todoDescriptionTextView.text.isEmpty
    }
    
    func fillData() {
        if let todo = todo {
            viewModel.setupData(data: todo)
            todoTitleTextField.text = todo.todoTitle
            todoDescriptionTextView.text = todo.todoDescription
            placeholderLabel.isHidden = !todoDescriptionTextView.text.isEmpty
        }
        checkboxImageView.image = viewModel.todoCompleted ? R.image.icons8Checked_checkbox()?.withRenderingMode(.alwaysTemplate) : R.image.icons8Unchecked_checkbox()?.withRenderingMode(.alwaysTemplate)
        checkboxImageView.tintColor = AppColor.blueCustom
    }
    
    @objc func saveTodo() {
        if let todoTitle = todoTitleTextField.text,
           let todoDescription = todoDescriptionTextView.text {
            if let _ = todo {
                viewModel.modifyDataRealm(todoTitle: todoTitle, todoDescription: todoDescription)
            } else {
                viewModel.addDataToRealm(todoTitle: todoTitle, todoDescription: todoDescription)
            }
        }
    }
    
    @IBAction func checkboxButtonClicked(_ sender: Any) {
        viewModel.todoCompleted = !viewModel.todoCompleted
        checkboxImageView.image = viewModel.todoCompleted ? R.image.icons8Checked_checkbox()?.withRenderingMode(.alwaysTemplate) : R.image.icons8Unchecked_checkbox()?.withRenderingMode(.alwaysTemplate)
        checkboxImageView.tintColor = AppColor.blueCustom
    }
}

extension TodoInfoViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
    }
}

extension TodoInfoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
