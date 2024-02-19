//
//  DetailListVC.swift
//  RealmTasks
//
//  Created by cuongdd on 08/05/2022.
//

import UIKit

class DetailListVC: BaseViewController {
    lazy var contextTextView: UITextView = {
        let textView = UITextView()
        textView.font = R.font.playfairDisplayMedium(size: 20)
        textView.backgroundColor = UIColor.clear
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    var mediaType = MediaTypeLocalModel()
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle(title: mediaType.title)
        addBackButton()
        
        view.layout(contextTextView)
            .below(titleLabel, 32)
            .left(16).bottomSafe(16).right(16)
    }
    
    private func fillData() {
        if let rtfPath = Bundle.main.url(forResource: mediaType.fileName, withExtension: "rtf") {
            do {
                let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: rtfPath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                
                let string = attributedStringWithRtf.string
                let replaced = string.replacingOccurrences(of: "*", with: "\n\n")
                
                let medium = R.font.playfairDisplayMedium(size: 20)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                paragraphStyle.firstLineHeadIndent = 5.0
                paragraphStyle.lineSpacing = 6
                
                let _ = NSAttributedString(
                    string: string,
                    attributes: [
                        .font: medium as Any,
                        .foregroundColor: UIColor.random,
                        .paragraphStyle: paragraphStyle
                    ]
                )
                
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: medium as Any,
                    .foregroundColor: UIColor.random,
                    .paragraphStyle: paragraphStyle
                ]
                
                let attributedQuote = NSAttributedString(string: replaced, attributes: attributes)
                self.contextTextView.attributedText = attributedQuote
            } catch let error {
                print("Got an error \(error)")
            }
        }
    }
}
