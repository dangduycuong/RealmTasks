//
//  SettingViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/02/2024.
//

import UIKit

class SettingViewController: BaseViewController {
    let tableView = UITableView()
    var tagorePoems = [Poem]()
    //    let thuongDeLaLaoDong = """
    //        """
    //    let mayVaSong = """
    //        """
    //
    //    - Mây và sóng
    //    - Bài số 28
    //    - Bài số 001
    //    - Ai đó
    //    - Bài số 01
    let imageView = UIImageView()
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func prepareForViewController() {
        if let extraBold = PlayfairDisplayFont.extraBold(with: 20) {
            let titleLabel = UILabel()
            titleLabel.text = "Cai Dat"
            titleLabel.font = extraBold
            titleLabel.textColor = UIColor.white
            view.layout(titleLabel)
                .centerX().topSafe()
            //            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: extraBold]
            
            
            let image = UIImage(named: "oldBookBackGroundImage")
            
            view.layout(imageView)
                .top().left().bottom().right()
            
            image?.prepareForDisplay { [weak self] preparedImage in
                DispatchQueue.main.async {
                    self?.imageView.image = preparedImage
                }
            }
        }
        
        let text = """
Bài số 011 - Thượng đế là lao động Poem 011

Tagore Rabindranath - Thơ dâng (1910)


Hát ca như vậy mà làm gì. Cầu kinh lần hạt làm gì. Hãy từ bỏ đi thôi. Anh thờ phụng ai trong xó tối ngôi đền đóng kín bốn bề vắng vẻ. Hãy mở mắt nhìn, làm gì có thượng đế trước mặt anh.

Thượng đế ở nơi người nông dân đang vất vả cày đất cằn sỏi cứng, nơi người công nhân đang đập đá làm đường.

Thượng đế đang ở cùng họ đổ mồ hôi dưới nắng mưa. Áo quần của Người cũng lấm bẩn đầy bụi. Hãy cởi áo lễ ra rồi cùng Thượng đế xông pha vào gió bụi.

Giải thoát ư? Anh biết tìm nơi đâu? Thượng đế cũng đã vui vẻ buộc vào mình những sợ dây của sáng tạo. Người tự buộc Người mãi mãi với chúng ta.

Hãy ra khỏi mọi suy tư, trầm mặc, cất cả hoa hương sang một bên, mặc cho quần áo rách bẩn, cứ thế đến bên Người trong lao động cùng cực trán đổ mồ hôi.


Bài thơ này từng được sử dụng trong phần đọc thêm SGK Văn học 11 giai đoạn 1990-2006 với bản dịch của Đào Xuân Quý, nhưng đã được lược bỏ trong SGK Ngữ văn 11 từ 2007.
"""
        let label = UILabel()
        
        label.text = text
        label.font = R.font.playfairDisplayMedium(size: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        
        let scrollView = UIScrollView()
        view.layout(scrollView)
            .topSafe().left().bottomSafe().right()
        
        let contentView = UIView()
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
        
        contentView.layout(label)
            .top(16).left(16).right(16)
        
        let title2Label = UILabel()
        title2Label.text = "Bài số 28\nTagore Rabindranath - Tâm tình hiến dâng (Người làm vườn) - The gardener"
        title2Label.numberOfLines = 0
        title2Label.font = R.font.playfairDisplaySemiBold(size: 20)
        contentView.layout(title2Label)
            .below(label, 32).left(16).right(16)
        
        
        let label2 = UILabel()
        label2.font = R.font.playfairDisplayMedium(size: 20)
        label2.numberOfLines = 0
        label2.textAlignment = .left
        
        let text2 = """
Đôi mắt em băn khoăn u buồn, đôi mắt em muốn dò hỏi ý nghĩa lời anh nói, như mặt trăng muốn soi vào đáy biển.

Anh đã phơi bày trần trụi đời mình trước mắt em, anh không giấu giếm điều gì. Chính vì thế mà em chẳng biết gì về anh.

Nếu đời anh chỉ là viên ngọc quý anh sẽ đập ra làm trăm mảnh xâu thành chuỗi quàng vào cổ em.

Nếu đời anh chỉ là bông hoa nhỏ bé, tròn xinh, thơm tho, anh sẽ ngắt nó ra cài lên mái tóc em.

Nhưng em ơi, đời anh là trái tim sao biết được đâu là bờ là đáy.

Em là nữ hoàng đang trị vì vương quốc nhưng có biết gì biên giới của nó.

Nếu trái tim anh chỉ là phút giây sướng vui, nó sẽ nở nụ cười dịu hiền và em sẽ thấu hiểu nó rất nhanh.

Nếu trái tim anh chỉ là nỗi thương đau, nó sẽ tan thành giọt lệ phản ánh nỗi sầu thầm kín.

Nhưng em ơi, trái tim anh là tình yêu.

Niềm vui sướng và nỗi khổ đau của nó là mênh mông, những gì tình yêu thiếu thốn và giàu có là bất tận.

Trái tim anh ở bên em như chính đời em, nhưng có bao giờ em biết hết nó đâu.


Bài thơ này từng được sử dụng trong chương trình SGK Văn học 11 giai đoạn 1990-2006 với bản dịch của Đào Xuân Quý, nhưng đã được chuyển thành đọc thêm trong SGK Ngữ văn 11 từ 2007.
"""
        
        label2.text = text2
        contentView.layout(label2)
            .below(title2Label, 16).left(16).right(16).bottom(16)
        
        scrollView.showsVerticalScrollIndicator = false
        
        readJSONFile(forName: "Tagore")
        
        
        
        var segmentedControl: UISegmentedControl!
        // Do any additional setup after loading the view, typically from a nib.
        segmentedControl = UISegmentedControl(items: ["First","Second","Third"])
        segmentedControl.frame = CGRectMake(60, 250,200, 30)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        self.view.layout(segmentedControl)
            .topSafe(32).left(16).right(16).height(40)
        
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        print("----", sender.selectedSegmentIndex)
    }
    
    func readJSONFile(forName name: String) {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let poemModel = try? JSONDecoder().decode(PoemModel.self, from: jsonData)
                
                if let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String: Any] {
                    print("JSON: \(json)")
                } else {
                    print("Given JSON is not a valid dictionary object.")
                }
            }
        } catch {
            print(error)
        }
    }
}
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let poemModel = try? JSONDecoder().decode(PoemModel.self, from: jsonData)

import Foundation

// MARK: - PoemModel
struct PoemModel: Codable {
    var author: String?
    var poems: [Poem]?
}

// MARK: - Poem
struct Poem: Codable {
    var title, content, note: String?
}
