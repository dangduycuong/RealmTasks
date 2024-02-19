//
//  TodoInfoViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit
import Material

class TodoInfoViewController: BaseViewController {
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var todoTitleTextField: UITextField! {
        didSet {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.random.withAlphaComponent(0.4),
                .font: R.font.playfairDisplayMediumItalic(size: 20) as Any
            ]
            let redPlaceholderText = NSAttributedString(
                string: "Enter Todo Title",
                attributes: attributes
            )
            todoTitleTextField.attributedPlaceholder = redPlaceholderText
            todoTitleTextField.font = R.font.playfairDisplayMedium(size: 20)
            todoTitleTextField.textColor = UIColor.random
        }
    }
    
    lazy var todoDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.font = R.font.playfairDisplayMedium(size: 20)
        textView.backgroundColor = .clear
        return textView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(saveTodoTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var checkboxButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(checkboxButtonClicked), for: .touchUpInside)
        return button
    }()
    
    var checkboxImageView = UIImageView()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var viewModel = TodoInfoViewModel()
    var todo: TodoModel?
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
        viewModel.delegate = self
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: "Chi tiết công việc")
        addBackButton()
        
        view.layout(scrollView)
            .below(titleLabel, 32).left().bottom().right()
        scrollView.addSubview(contentView)
        scrollView.layoutIfNeeded()
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalToConstant: scrollView.bounds.width)
        ])
        let heightConstraint = NSLayoutConstraint(item: contentView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        contentView.addConstraints([heightConstraint])
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        todoTitleTextField = UITextField()
        contentView.layout(todoTitleTextField)
            .top().left(16).right(16).height(40)
        
        contentView.layout(todoDescriptionTextView)
            .below(todoTitleTextField, 16).left(16).right(16)
        
        contentView.layout(checkboxButton)
            .below(todoDescriptionTextView, 16).left(16).right(16).bottom().height(40)
        
        contentView.layout(checkboxImageView)
            .centerY(checkboxButton).left(16).width(24).height(24)
        
        let image = R.image.icons8Done()?.withRenderingMode(.alwaysTemplate)
        let saveImageView = UIImageView(image: image)
        saveImageView.tintColor = UIColor.random
        
        view.layout(saveButton)
            .centerY(titleLabel).right(16).width(44).height(44)
        
        view.layout(saveImageView)
            .center(saveButton).width(24).height(24)
        
        checkboxButton.setTitle("", for: .normal)
        placeholderLabel = UILabel()
        placeholderLabel.text = "Enter some text..."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (todoDescriptionTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        todoDescriptionTextView.addSubview(placeholderLabel)
        
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (todoDescriptionTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.random
        placeholderLabel.isHidden = !todoDescriptionTextView.text.isEmpty
        
        let titleButtonCheckBox = UILabel()
        contentView.layout(titleButtonCheckBox)
            .after(checkboxImageView, 8).centerY(checkboxImageView)
        titleButtonCheckBox.text = "Completed"
        titleButtonCheckBox.font = R.font.playfairDisplayMedium(size: 20)
    }
    
    @objc private func saveTodoTapped(_ sender: UIButton) {
        view.endEditing(true)
        if let todoTitle = todoTitleTextField.text,
           let todoDescription = todoDescriptionTextView.text {
            if let _ = todo {
                viewModel.modifyDataRealm(todoTitle: todoTitle, todoDescription: todoDescription)
            } else {
                viewModel.addDataToRealm(todoTitle: todoTitle, todoDescription: todoDescription)
            }
        }
    }
    
    func fillData() {
        if let todo = todo {
            viewModel.setupData(todo: todo)
            todoTitleTextField.text = todo.todoTitle
            todoDescriptionTextView.text = todo.todoDescription
            placeholderLabel.isHidden = !todoDescriptionTextView.text.isEmpty
        }
        checkboxImageView.image = viewModel.todoCompleted ? R.image.icons8Checked_checkbox()?.withRenderingMode(.alwaysTemplate) : R.image.icons8Unchecked_checkbox()?.withRenderingMode(.alwaysTemplate)
        checkboxImageView.tintColor = UIColor.random
    }
    
    @IBAction func checkboxButtonClicked(_ sender: Any) {
        viewModel.todoCompleted = !viewModel.todoCompleted
        checkboxImageView.image = viewModel.todoCompleted ? R.image.icons8Checked_checkbox()?.withRenderingMode(.alwaysTemplate) : R.image.icons8Unchecked_checkbox()?.withRenderingMode(.alwaysTemplate)
    }
}

extension TodoInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        todoTitleTextField.tintColor = UIColor.random
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
    }
}

extension TodoInfoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}

extension TodoInfoViewController: SaveTodoInfoDelegate {
    func savedTodo(message: String, type: TodoTask) {
        let titleLeftButton = type == .add ? "Continue" : nil
        let titleRightButton = type == .error ? "OK" : "Done"
        showAlert(type: .notice, titleAlert: nil, message: message, titleLeftButton: titleLeftButton, titleRightButton: titleRightButton, leftAction: {
            self.resetDataDisplay()
        }, rightAction: {
            if type != .error {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    func resetDataDisplay() {
        todoTitleTextField.text = ""
        todoDescriptionTextView.text = ""
        viewModel.todoCompleted = false
        todoTitleTextField.becomeFirstResponder()
        checkboxImageView.image = viewModel.todoCompleted ? R.image.icons8Checked_checkbox()?.withRenderingMode(.alwaysTemplate) : R.image.icons8Unchecked_checkbox()?.withRenderingMode(.alwaysTemplate)
    }
}
