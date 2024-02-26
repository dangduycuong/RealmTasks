//
//  DiaryEditViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 24/02/2024.
//

import UIKit

class DiaryEditViewController: BaseViewController {
    lazy var contextTextView: UITextView = {
        let textView = UITextView()
        textView.font = R.font.playfairDisplayMedium(size: 20)
        textView.backgroundColor = UIColor.clear
        textView.showsVerticalScrollIndicator = false
        textView.delegate = self
        textView.textColor = mainColor
        
        return textView
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var diaryModel: DiaryModel?
    private var mainColor = UIColor.random
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fillData()
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: "Nhật ký hôm nay", color: mainColor)
        addBackButton(color: mainColor)
        
        view.layout(contextTextView)
            .below(titleLabel, 32)
            .left(16)
            .right(16)
            .height(view.bounds.height / 2)
        
        let saveButton = UIButton()
        view.layout(saveButton)
            .left(16)
            .bottomSafe(16)
            .right(16)
            .height(40)
        saveButton.setTitle("Lưu Lại", for: .normal)
        saveButton.titleLabel?.font = R.font.playfairDisplayMedium(size: 20)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.setTitleColor(mainColor, for: .normal)
        
        placeholderLabel.text = "Enter some text..."
        placeholderLabel.font = R.font.playfairDisplayMediumItalic(size: 20)
        placeholderLabel.sizeToFit()
        contextTextView.addSubview(placeholderLabel)
        
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (contextTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = mainColor
        placeholderLabel.isHidden = !contextTextView.text.isEmpty
    }
    
    func fillData() {
        contextTextView.text = diaryModel?.content
        if let upDateTime = diaryModel?.upDateTime {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "vi_VN")
            dateFormatter.dateFormat = "'Sửa đổi lúc' HH:mm:ss EEEE',' 'Ngày' dd-MM-YYYY"
            
            let updateLabel = UILabel()
            updateLabel.font = R.font.playfairDisplayMedium(size: 20)
            updateLabel.text = dateFormatter.string(from: upDateTime)
            
            view.layout(updateLabel)
                .below(contextTextView, 16)
                .leading(contextTextView)
        }
    }
    // MARK: - Actions
    @objc func saveButtonTapped(_ sender: UIButton) {
        if let text = contextTextView.text {
            let diaryModel = DiaryModel()
            let id = UUID().uuidString
            diaryModel.id = id
            diaryModel.content = text
            diaryModel.dateTime = Date.now
            
            if let diary = self.diaryModel {
                diaryModel.id = diary.id
                diaryModel.dateTime = diary.dateTime
                diaryModel.content = text
                diaryModel.upDateTime = Date.now
                DataManager.shared.modifyDiary(dataEdit: diaryModel)
                showAlert(type: .notice, message: "Nội dung đã được cập nhật", titleLeftButton: "Trở Lại", titleRightButton: "Đồng Ý", leftAction: {
                    self.navigationController?.popViewController(animated: true)
                }, rightAction: {})
            } else {
                DataManager.shared.addDiaryToRealm(diaryModel)
                showAlert(type: .notice, message: "Đã thêm thông tin", titleLeftButton: "Trở Lại", titleRightButton: "Đồng Ý", leftAction: {
                    self.navigationController?.popViewController(animated: true)
                }, rightAction: {})
            }
        }
    }
}

extension DiaryEditViewController: UITextViewDelegate {
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        placeholderLabel.isHidden = !contextTextView.text.isEmpty
    }
}
