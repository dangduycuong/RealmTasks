//
//  DetailListVC.swift
//  RealmTasks
//
//  Created by cuongdd on 08/05/2022.
//

import UIKit

class DetailListVC: BaseViewController {
    
    @IBOutlet weak var contextTextView: UITextView!
    
    var mediaType = MediaTypeLocalModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fillData()
    }
    
    private func setupUI() {
        addBackButton()
        title = mediaType.title
    }
    
    private func fillData() {
        if let rtfPath = Bundle.main.url(forResource: mediaType.fileName, withExtension: "rtf") {
            do {
                let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: rtfPath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                
                let string = attributedStringWithRtf.string
                let replaced = string.replacingOccurrences(of: "*", with: "\n\n")
                
                let regular = PlayfairDisplayFont.regular(with: 20)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                paragraphStyle.firstLineHeadIndent = 5.0
                
                let _ = NSAttributedString(
                    string: string,
                    attributes: [
                        .font: regular as Any,
                        .foregroundColor: UIColor.black,
                        .paragraphStyle: paragraphStyle
                    ]
                )
                
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: regular as Any,
                    .foregroundColor: UIColor.blue,
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
