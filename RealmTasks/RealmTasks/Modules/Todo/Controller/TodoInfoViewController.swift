//
//  TodoInfoViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit
import Material

class TodoInfoViewController: BaseViewController {
    
    @IBOutlet weak var todoTitleTextField: UITextField! {
        didSet {
            let redPlaceholderText = NSAttributedString(string: "Enter Todo Title",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            
            todoTitleTextField.attributedPlaceholder = redPlaceholderText
        }
    }
    @IBOutlet weak var todoDescriptionTextView: UITextView!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var checkboxImageView: UIImageView!
    
    var placeholderLabel : UILabel!
    
    var viewModel = TodoInfoViewModel()
    var todo: TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillData()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        let image = R.image.icons8Done()?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        imageView.tintColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(saveTodo(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        let rightBarButtonItem = UIBarButtonItem(customView: imageView)
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
    
    @objc func saveTodo(tapGestureRecognizer: UITapGestureRecognizer) {
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
        checkboxImageView.tintColor = .white
    }
    
    @IBAction func checkboxButtonClicked(_ sender: Any) {
        viewModel.todoCompleted = !viewModel.todoCompleted
        checkboxImageView.image = viewModel.todoCompleted ? R.image.icons8Checked_checkbox()?.withRenderingMode(.alwaysTemplate) : R.image.icons8Unchecked_checkbox()?.withRenderingMode(.alwaysTemplate)
    }
}

extension TodoInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        todoTitleTextField.tintColor = .white
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
