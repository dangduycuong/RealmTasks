//
//  SettingViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/02/2024.
//

import UIKit

class SettingViewController: BaseViewController {
    
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
Nhàn đàm ĐIỀU QUÝ GIÁ VÀ TÍNH DÂM TỤC VỀ "CÁI ẤY" TRONG CA DAO, TỤC NGỮ
Đỗ Trọng KhơiThứ bẩy ngày 28 tháng 11 năm 2020 5:05 AM




Bao giờ thong thả lên chơi nguyệt

Cho cả cành đa lẫn củ đa…

Chiêu Hổ


Nói đến thơ văn viết về "cái ấy", "chuyện ấy" thì tự ngàn xưa có tiếu lâm, ca dao, phương ngôn tục ngữ, và mấy trăm năm dòng văn học thành văn cũng đã từng lưu. Hơn thế nhiều nơi có đền thờ, hàng năm tổ chức lễ hội rước đôi sinh thực khí, cái nõ cái nường. Sách Dịch viết "Nhất âm nhất dương thành đạo". Âm, chỉ về cái âm khí, âm hộ của giống cái - đàn bà. Dương, chỉ về cái dương khí, dương vật của giống đực - đàn ông, khi hai cái sinh khí này giao hợp với nhau để sinh trưởng, gọi là Đạo. Đạo - quy luật tự nhiên, duy trì sự sống. Đó là đôi báu vật vô ngần quý giá, mầu nhiệm không gì so sánh được. Qúy giá là vậy nhưng trong sinh hoạt thường nhật nói/viết về đôi sinh thực khí nõ nường đó bằng tên tục của nó lại dễ bị chê dâm tục.

Văn học thành văn Việt Nam có không ít tác giả tác phẩm đề cập tới "cái ấy", "chuyện ấy". Thi hào Nguyễn Du với Truyện Kiều cũng đã dành cho "cái ấy" những câu kỳ tuyệt: "Dày dày sẵn đúc một tòa thiên nhiên", "chuyện ấy": "Vành ngoài bảy nhẽ vành trong tám nghề / Chơi cho liễu chán hoa chê / Cho lăn lóc đá cho mê mẩn đời"…Bà Chúa thơ Nôm Hồ Xuân Hương thì gần như không bài thơ nào không gắn với hình ảnh của cái ấy, chuyện ấy. Chơi chữ, nhại chữ có bài Sư hoạnh dâm: "Cái kiếp tu hành nặng đá đeo / Làm chi một chút tẻo tèo teo / Thuyền từ cũng muốn về Tây Trúc / Trái gió cho nên phải lộn lèo". Mượt mà, ý tứ có bài Cái giếng: "…Cầu trắng phau phau hai ván ghép / Nước trong leo lẻo một dòng thông / Cỏ gà lún phún leo quanh mép / Cá diếc le te lội giữa dòng…" Đố tục giảng thanh, bóng gió có các bài Vịnh cái quạt, Bánh trôi, Quả mít, Con ốc nhồi…vv.

Văn học dân gian trong ca dao, tục ngữ thường lại không e dè khi dùng hình ảnh câu chữ về cái ấy đúng nghĩa đen mà vẫn đạt được nhiều cung bậc biểu cảm, khi hài tiếu, giễu cợt, lúc huỵch toẹt chẻ hoe, đầy vẻ sâu cay và thi vị riêng. Có thể khẳng định với đề tài này văn học dân gian thành công hơn ở tính đa dạng, đa tầng và phong phú hơn trong cách miêu tả.

Nếu chỉ là ngôn ngữ giao tiếp thông thường chưa dễ ai dám nói với nhau như sau, song khi đã được chân thực hóa một cách điệu nghệ và trở lên như một bài học, một lời ta thán hay nhắc nhủ, thì những hình ảnh câu chữ đó đã được chấp nhận và truyền tụng.

Như các câu:

Đẻ con khôn mát lồn rười rượi

Đẻ con dại thảm hại cái lồn

*

Văn chương chữ nghĩa bề bề

thần lồn ám ảnh cũng mê mẩn đời

*

Buồi ơi cha tổ thằng buồi

chịu nhịn chịu nhục mà chui vào lồn

Lại đôi khi chỉ cần hạ một câu thẳng đơ, chắc nịch mà vẫn gây được cái cười nụ ý nhị:

To lồn hơn đẹp mặt

Lồn to không lo chết đói

Lồn năng mó, vó năng cất.


Lại có lúc bóc mẽ giễu nhại các bậc phu quân mũ cao áo dài:

Múi mít hạt hồng,

lá vông rễ ấu

Xấu thì thật xấu,

xem vẫn muốn xem

Nói đến thì thèm,

bảo ăn lại giận.

*

Quan sai không bằng lồn khiến

Còn những câu ca dao dưới đây ở góc tỏ bày rất khác, nó bóng bẩy, ý hay, hình đẹp, có tính phát hiện và tỏ rõ sự từng trải:

Trên đời nhất đẹp là lồn

nhất ngon là muối, nhất khôn là tiền

*

Làm trai cho đáng nên trai

miệng thơm mùi thuốc, tay khai mùi lồn

*

Lồn nào mà chẳng có lông,

có năm ba cái cho chồng vuốt chơi

Dù ai cũng nếm, trải mà ai cũng không khỏi bất ngờ gặp câu nhận định sướng tê người: "nhất ngon là muối" chứ không phải ngon nhất là gan rồng tủy phượng, "nhất không là tiền" chứ phải đâu một ông/bà nào đó khôn nhất. Rồi câu "miệng thơm mùi thuốc", nghe qua thấy nhẹ hều, ngờ ngợ là thuốc lá thuốc lào, thậm chí thuốc phiện thì cũng có gì đặc biệt mà phải gieo câu "cho đáng nên trai"? Hẳn phải có lý do nào đó mà chúng ta, người đương thời chưa tỏ tường. Ví như đó là thứ thuốc được trồng ở tít đất quê xa xôi hẻo lánh, hoặc được hút trong hoàn cảnh đặt biệt, với kỹ thuật xao tẩm, vê se mồi lửa riêng biệt mới khiến người trong cuộc được trải nghiệm không thể không cảm khái mà thốt lên lời hoan hỉ.

Rồi lại có lúc điệu vợi xa xôi, câu ca dao thành ra bài học chọn vợ:

Cô nào mắt Phượng mày Ngài

lông lồn đốt cũng được vài đống tro

Cô nào vú nhỏ mông to

lỗ lồn cứ phải chèo đò mới sang

Cô nào má đỏ hồng hồng

nước lồn tát mấy gầu sòng chưa vơi

*

Có phúc thì lồn có lông

vô phúc thì lại sạch không làu làu

*

Đẻ con phải biết tính con

hễ vú gai gạo thì lồn chớp đông…

Hầy hầy! Ca thế có khác chi đơn thuốc thầy lang, quẻ bói thầy đồ. Thật là các cụ dân gian nhà ta luận chuyện dâm tài tình tinh vi hết nhẽ!

Thời xưa đã vậy, thời nay thơ, ca dao có viết về cái ấy, chuyện ấy không? Thưa rằng đã mang thân xác con người thì cái cảm xúc ái tình, ố tình về cái ấy, chuyện ấy người thời nào chả xao y bản gốc vậy. Khác là khác ở cách dùng hình ảnh thể hiện. Xưa mượn cái nơm cái te, nay mượn cái xe cái pháo.

Lồn cướp mất sao, lồn cào mất gạch

Lồn gì lồn ác quá tai, lồn nuốt súng lục, lồn nhai quân hàm

Cả đời phấn đấu không bằng lồn giao cấu một đêm

Đánh đề không lộn ăn lồn trẻ con

Lồn chằng ghế đá, lồn vá xe hơi

*

Nỏ cần bằng cấp cần tiền

có cái lồn đẹp chức liền trao ngay

lồn dắt sếp đi đó đây

chạng cho sếp úp, thọc tay sếp rờ!

*

Thứ nhất còn ông cháu cha

thứ nhì lồn phải bằng cái lá đa đầu làng

*

Lồn ăn xong lên võng lồn nằm

lồn sai cán bộ lấy tăm cho lồn

*

Dù cho trăm khéo ngàn khôn

vấp phải thần lồn xuống dốc không phanh

*

Vợ tôi nửa dại nửa khôn

ngày dăm bảy bận dí lồn vào thơ

còn tôi ra ngẩn vào ngơ

ngày dăm bảy lượt dí thơ vào lồn

(4 câu lục bát này của tác giả Bùi Hoàng Tám, Thái Bình)

Điểm khác ca dao, tục ngữ ngày nay thường mượn hình ảnh cái ấy, chuyện ấy để chế giễu, phê phán về người có quyền chức hay dụng cái ấy để chạy chức. Ca dao, tục ngữ của người xưa chủ yếu đem chuyện ấy ra nhằm mua vui, to nhỏ nhắc nhở nhau việc đời.

Văn học miền Nam thời trước 1975, các tác giả Bùi Giáng, Nguyễn Đức Sơn cũng có những tác phẩm viết về "cái ấy", "chuyện ấy" cách điệu, nói tránh nói lái đi với hình dung biểu cảm khác, thành một thi phẩm hoàn chỉnh và cũng được lưu truyền.

Thi sỹ Nguyễn Đức Sơn có câu thơ vào hàng khủng. chưa rõ ở bài nào: " Cầu tiêu em ỉa quên chưa dội/Bãi cứt nhìn qua hiện đóa hồng", cùng với loạt bài:


anh sẽ đến bất ngờ ai biết trước

miệng khô rồi nẻo cực lạc xa xôi

ôi một đêm bụi cỏ dáng thu người

em chưa đái mà hồn anh đã ướt

(Vũng nước thánh)

*

Luận về không hay có

Đâu bằng nhìn cái mồng của em

Sắp ló

(Cái mồng sắp ló)

*

Con gái

Ngồi đái

Trên Trái Đất

Rồi đi đâu mất

(Tôi thấy)

Thi sỹ Bùi Giáng không chỉ có thơ mà còn giãi bày chuyện ấy bằng văn xuôi và thi sỹ đã "cố" kín đáo để tránh điều dâm tục:

Trời xanh úp mặt nghe tin

Thôi rồi! Em Má Ri Lyn đi rồi

Từ đây ta bỏ ngai trời

Thu thời gian đập tơi bời càn khôn

Giữa hư vô nếu em còn

Nhớ ta em gửi cái hồn cho ta

Úp môi ôm mặt khóc oà

Cồn lê lên miệng là ba bốn lần”.

(Trời khóc Marilyn)

Còn đây một đoạn văn kinh dị : “Cô Kim Cương hãy đi tiểu trên nấm mồ tại hạ vẫn vĩnh viễn là ngôn ngữ tuyệt trù bất tận thi nhiên. Vì chỉ nói như vậy thì ngàn vạn năm sau riêng hình ảnh cô Kim Cương sẽ vĩnh viễn đi về Trong Tháng Ba Lễ Hội để giải oan cho Tượng Vương hồi xứ Hoa Nghiêm Kinh...”... “Cô Kim Cương hãy đi tiểu trên nấm mồ tại hạ là sự vụ cần yếu ban sơ cho cuộc tối sơ đi về huỷ thân giữa trần thổ. Cô Kim Cương vén xiêm đi tiểu xong rồi, thì từ nấm mồ của trần thổ huỷ thân đó sẽ nảy nở ra cuộc đầu thai nơi núi đá...”.

Hì, thật hết biết cái ấy nó mê lầm càn khôn, lên thì tuyệt đỉnh, xuống thì tận đáy cỡ đó mới sinh hạ thứ văn chương nghe thấy điên điên khùng khùng mà ngẫm thấy rất mực nâng niu thương mến con người.

***

Trên mới nói ca dao tục ngữ về "cái ấy" của đàn bà, còn "cái ấy" của đàn ông, có không? Xin thưa có chứ, chỉ thất vọng chút là số lượng ít hơn, phẩm lượng cũng hiếm câu hay ho thú vị bằng. Phải chăng nghĩ và viết về cái ấy, chuyện ấy chủ yếu do cánh đàn ông đặt bày, vẽ chuyện, chị em vốn kín đáo, ý nhị nên ít góp lời vui? Tuy vậy tính dâm tục thì những câu kể về cái ấy, chuyện ấy của đàn ông được bày ra có phần ba trợn sít sao hơn:

Bây giàu bây có lồn to,

choa nghèo choa có trời cho cặc dài.

*

Ai ơi chớ gọi cái lồn

gọi là cái tiểu để chôn cái buồi

*

Lồn tao tao vỗ tao chơi

sao mày lại cứng con buồi mày lên

*

Lồn ơi tao khổ vì lồn

vì mày có lỗ mày chôn đầu buồi

Cũng có câu được khuyên son nhè nhẹ:

Xa như buồi giời; Cơm no cò đói; Sướng con cu mù con mắt; Chưa giàu đã lấy buồi làm then cửa; Chưa nặn Bụt đã nặn buồi; Lồn lá tre, buồi xe điếu; Lồn lá vông, buồi tông cán; Chồng ướt dái vợ sái răng hàm; Trai thích chè đặc, gái thích cặc dài; Trai sờ dái, gái sờ lồn; Qua sông đấm bòi vào sóng; Của lồn lồn đòi, của buồi buồi quên; Dạ vâng trước mặt trật cặc sau lưng; Con mày con nuôi không bằng con buồi sinh ra…

Và:

Chim trời bóp cái chết ngay

chim nhà mà bóp càng ngày càng to

*

Chim khôn chim ngẩng cao đầu

bướm khôn bướm đậu vào đầu chim khôn

*

Chồng người vượt lạch rẽ ngòi

chồng em xó bếp đầu bòi chấm gio

*

Thăm nhau phải đến đêm hôm.

rảnh rang nói chuyện cặc lồn mới vui.

*

Nứng cặc thì vặc đến nhà

lồn còn đau mắt không ra đến ngoài

*

Lồn nào mà chẳng có lông

buồi nào mà chẳng muốn tông vào lồn

*

Giữ dao phải giữ lấy chuôi

giữ chồng phải giữ cái buồi của anh

***

Ấy là lời lẽ thuở ca dao, tục ngữ xưa, còn ca dao tục ngữ nay về cái ấy của nam giới cũng không ít. Thậm chí có một nhà thơ dân gian nổi tiếng chuyên viết về chuyện này.

Ca dao, tục ngữ thời nay:

Lồn gái Xuân Mai, buồi trai nghĩa vụ

*

Về hưu quen thói to mồm

nếu không lao động lấy lồn mà ăn

*

Ra đường sợ nhất Min khơ

về nhà sợ nhất vợ sờ vào chim

khôn hồn thì hãy nằm im

giả vờ say rượu thì chim mới bền

*

1. Nếu không hiểu rõ con cu / đọc vạn quyển sách vẫn ngu như bò; 2. Anh đi công tác Pờ lây / Ku dài dằng dặc biết ngày nào ra; 3. Ngày xưa kéo pháo Điện Biên/ bây giờ "kéo pháo" lên quần chị em… (3 cặp lục bát sau của tác giả Bảo Sinh, Hà Nội)

*

Nào biết ai đã đặt ra cái tên gọi kỳ độc Buồi, Lồn và đặt tự bao giờ, song điều ai cũng thấy tên hai báu vật đó đã được đặt vô cùng chính xác, thâm thúy đến nỗi tên Trời - thiên, Thánh, Thần còn có người dám dụng, chứ chữ Buồi, Lồn thì tuyệt không một bậc cha mẹ nào dám cả gan dụng làm danh từ riêng cho con cháu. Khéo đến thế, tài tình tinh vi đến thế thực là tột bậc!

Thơ văn, ca dao, tục ngữ, hò vè về cái ấy, chuyện ấy chắc chắn còn được tiếp nối đồng hành với đời sống sinh hoạt văn hóa, giao hợp âm dương nam nữ của con người trên thế gian này sẽ không bao giờ dứt. Vì vậy, việc bàn luận khi trà dư tửu hậu, nơi phòng sáng hay trong buồng tối cũng không thể dừng. Nay nhân trên trang FB cá nhân của nhà thơ, nhà báo Bùi Hoàng Tám, ngày 31 tháng 10 năm 2020 đã khơi gợi ra câu chuyện này, nhờ đó tôi lượm lại được nhiều câu ca dao, tục ngữ thú vị, sau khảo cứu thêm thơ ở những sách khác để có đủ tư liệu cho bài viết lúc lòng được nhàn dỗi, vui vẻ. Tôi có mấy lời bàn vui vui, xin tri âm nhà thơ Bùi Hoàng Tám cùng các bạn đã cung cấp tư liệu và cũng xin phép được tạm dừng ở đây.

Một đêm thanh vắng.

Tp Thái Bình, 9/11/2020

ĐỖ TRỌNG K
"""
        let medium = R.font.playfairDisplayMedium(size: 20)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.firstLineHeadIndent = 5.0
        paragraphStyle.lineSpacing = 6
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: medium as Any,
            .foregroundColor: UIColor.blue,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedQuote = NSAttributedString(string: text, attributes: attributes)
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.attributedText = attributedQuote
        
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
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
            .top(16).left(16).right(16).bottomSafe(16)
        
    }
    
}

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
