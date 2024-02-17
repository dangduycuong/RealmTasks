//
//  WisdomDetailViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import UIKit

class WisdomDetailViewController: BaseViewController {
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = R.font.playfairDisplayMedium(size: 20)
        textView.delegate = self
        textView.backgroundColor = UIColor.clear
        textView.isScrollEnabled = false
        return textView
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var viewModel = WisdomDetailViewModel()
    var wisdom = WisdomModel()
    var isViewWisdomDetail: Bool = false
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setupData(isViewWisdomDetail: isViewWisdomDetail, wisdom: wisdom)
        viewModel.delegate = self
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: R.string.localizable.todo())
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
        
        contentView.layout(contentTextView)
            .top().left(16).bottom().right(16)
        
        placeholderLabel.text = "Enter some text..."
//        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (contentTextView.font?.pointSize)!)
        placeholderLabel.font = R.font.playfairDisplayMediumItalic(size: 20)
        placeholderLabel.sizeToFit()
        contentTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (contentTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        placeholderLabel.isHidden = !contentTextView.text.isEmpty
        addRightBarButtonItems()
    }
    
    private func addRightBarButtonItems() {
        let image = R.image.icons8Done()?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        
        imageView.tintColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(saveClicked(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        view.layout(imageView)
            .bottomSafe(16).right(16).width(24).height(24)
        
        if isViewWisdomDetail {
            fillData()
            let deleteButton = UIButton()
            deleteButton.backgroundColor = UIColor.red
            view.layout(deleteButton)
                .bottomSafe(16).before(imageView, 16).width(24).height(24)
            deleteButton.addTarget(self, action: #selector(deleteItemClicked), for: .touchUpInside)
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
