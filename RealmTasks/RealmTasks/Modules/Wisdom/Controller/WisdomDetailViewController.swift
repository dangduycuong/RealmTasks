//
//  WisdomDetailViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import UIKit

class WisdomDetailViewController: BaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    
    private var placeholderLabel: UILabel!
    var viewModel = WisdomDetailViewModel()
    var wisdom = WisdomModel()
    var isViewWisdomDetail: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.setupData(isViewWisdomDetail: isViewWisdomDetail, wisdom: wisdom)
        viewModel.delegate = self
    }
    
    private func setupUI() {
        addBackButton()
        title = "Tri Muu"
        placeholderLabel = UILabel()
        placeholderLabel.text = "Enter some text..."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (contentTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        contentTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (contentTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !contentTextView.text.isEmpty
        addRightBarButtonItems()
    }
    
    private func addRightBarButtonItems() {
        let image = R.image.icons8Done()?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        imageView.tintColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(saveClicked(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        let rightBarButtonItem = UIBarButtonItem(customView: imageView)
        navigationItem.rightBarButtonItems = [rightBarButtonItem]
        
        if isViewWisdomDetail {
            fillData()
            let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteItemClicked))
            delete.tintColor = .white
            navigationItem.rightBarButtonItems = [rightBarButtonItem, delete]
        }
    }
    
    @objc func saveClicked(tapGestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        viewModel.addWisdom(content: contentTextView.text)
    }
    
    @objc private func deleteItemClicked() {
        viewModel.deleteModify()
    }
    
    private func fillData() {
        contentTextView.text = wisdom.content
    }
}

extension WisdomDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}

extension WisdomDetailViewController: WisdomDetailViewModelDelegate {
    func showResultAction(task: WisdomTaskResult) {
        switch task {
        case .add:
            showAlert(type: .notice, message: "Thêm thành công", titleLeftButton: "Tiếp Tục", titleRightButton: "Xong", leftAction: {
                self.contentTextView.text = ""
            }, rightAction: {
                self.navigationController?.popViewController(animated: true)
            })
        case .modify:
            showAlert(type: .notice, message: "Sửa nội dung thành công. Bạn có muốn thêm nội dung khác!", titleLeftButton: "Tiếp Tục", titleRightButton: "Xong", leftAction: {
                self.contentTextView.text = ""
                self.navigationItem.rightBarButtonItems?.remove(at: 1)
            }, rightAction: {
                self.navigationController?.popViewController(animated: true)
            })
        case .delete:
            showAlert(type: .notice, message: "Xoá thành công. Bạn có muốn thêm nội dung khác!", titleLeftButton: "Tiếp Tục", titleRightButton: "Xong", leftAction: {
                self.contentTextView.text = ""
                self.navigationItem.rightBarButtonItems?.remove(at: 1)
            }, rightAction: {
                self.navigationController?.popViewController(animated: true)
            })
        case .error:
            showAlert(type: .error, message: "Vui Lòng nhập nội dung", titleLeftButton: "Tiếp Tục", titleRightButton: "Hủy", leftAction: {
                self.contentTextView.becomeFirstResponder()
            }, rightAction: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
}
