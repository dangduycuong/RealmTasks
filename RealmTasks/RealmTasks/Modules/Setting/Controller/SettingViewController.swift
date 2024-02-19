//
//  SettingViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/02/2024.
//

import UIKit

class SettingViewController: BaseViewController {
    
    let imageView = UIImageView()
    let contentLabel = UILabel()
    
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


----


Tình Dục trong Ca Dao
 
Tình Dục là một khía cạnh văn hóa, một sắc thái rất đặc trưng, một vấn đề rất đời thường và luôn luôn hiện diện trong cuộc sống của con người. Nghiên cứu sâu về Tình Dục thì không thể bỏ qua khía cạnh văn hóa này, vì ở đó nó thể hiện được quan niệm của mỗi dân tộc, mổi sắc dân thậm chí là từng vùng nhỏ địa lý, tình dục dược nói đến trong các tác phẫn văn học nổi tiếng như Truyện Kiều, Cung Oán Ngâm Khúc, Bích Câu Kỳ Ngộ, Phan Trần, Hoa Tiên... và cũng là một đề tài vô cùng phong phú trong ca dao. Ca dao VN là một loại văn chương bình dân có một sức mô tả rất sinh động tất cả nếp sống, sinh hoạt, phong tục tập quán xã hội của đại đa số dân chúng, nó được thể hiện qua lối nói rất giản dị, thẳng thắng, trung thực không màu mè, chải chuốt,là một kho tàng bất tận để khai thác trong nhiều lãnh vực khác. Khảo sát về mặt tình dục trong ca dao VN mới thấy được những nhận xét thật uyên bác rất tinh tế của người nông dân, mới thấy được sự mô tả tâm tư, tình cảm, sự rung động về tình yêu, sự khao khát và nỗi đam mê về thân xác là rất thật, rất đời thường. Bộ mặt tình dục trong loại văn chương bình dân thể hiện theo đúng nghĩa đen lẫn nghĩa bóng của mỗi chữ, mỗi câu nói điều đó có thể làm cho một số nhà
" đạo đức " lên án là dâm ô, tục tỉu, những chuyện không nên nói nơi chỗ đông ngườị Sự thật là: dù có chỉ trích thế nào đi nữa thì nó vẫn đã tồn tại và sẽ tồn tại vì nó là ý thức châm biếm, óc hài hước của dân tộc, của một lớp người bình dân trong suốt lịch sử tồn tạị

Hôm qua lên núi hái chè
Gặp thằng phải gió nó đè em ra
Em lạy mà nó chẳng tha
Nó đè nó nhét cái mả cha nó vào!

Lại có câu:

Văn chương chữ nghỉa bề bề
Thần lồn. ám ảnh mà mê mẫn đời

Hóa ra Thần lồn. chi phối cả cuộc sống, bởi vậy không lạ khi người Champa đem hai "cái ấy" Yoni và Linga đễ thờ phươ.ng. Ngày xưa người Việt cũng như người Tàu đều có khuynh hướng sùng bái tính dục bao gồm sự sùng bái cơ quan sinh dục, sùng bái chuyện sinh nở, sùng bái vấn đề tính giaọ Cho nên trong ca dao người ta nói nhiều đến chuyện nàỵ Ông Đổng, bà Banh có thể xem là biểu tượng về tình dục trong ca dao

Có chồng từ thuở mười lăm.
Chồng chê tôi nhỏ không nằm cùng tôị
Đến chừng mười chín đôi mươị
Tôi ngủ dưới đất chàng lôi lên giường
Một rằng thương, hai rằng thương
Có bốn cẳng giường gãy một còn ba!

Hết đồng anh lại pha chì
Anh hàn chín tháng cô mình thụ thai
Sinh ra được thằng bé con trai
Về sau, giống bố gặp ai nó cũng hàn.

Tròng trành như nón không quai
Như thuyền không lái như ai không chồng

Thôi thôi, tôi van câu rằng đừng
Tôi lạy cậu rằng đừng
Tuổi tôi còn bé chưa từng nguyệt hoa
Tôi về gọi chị tôi ra
Chi tôi đã lớn nguyệt hoa đã từng

Em đừng khinh quân tử nhỏ nhoi
Con lươn bao lớn nó xoi lủng bờ.

Em ơi đừng thấy nhỏ mà rầu
Con ong bây lớn đốt cái bầu cù queo!

Em ơi đừng thấy nhỏ mà khinh
Con thằn lằn bây lớn ôm cây cột đình tổ cha!

Chú ý: Tổ cha: tiếng địa phương có nghĩa là rất lớn

Em đừng chê anh nhỏ mà lầm
Hòn đá đập nằm dưới,
hòn đá cầm nằm trên
Chẳng thà nó nhỏ mà dài
Còn hơn chụp bụp nữa ngoài nữa trong
(Chụp bụp nghĩa là to mà ngắn)

Chẳng thà nó nhỏ mà cong
Còn hơn tổ bố nửa trong nửa ngoài

Cồng cộc bắt cá bầu eo
Chi chê tôi bé, tôi trèo chị coi

Câu đố:
C.. ba chia đút vô lồn. ngoáy
Chãy máu ra lè lưởi liếm liền

Câu đố:
Ngất nga ngất ngưỡng tựa cần câu
Tay chân không có miệng trên đầu

Câu đố:
Đi nhai, đứng ngậm ngồi cười.

L.. này lồn. chẳng sợ ai
Sợ thằng say rượu đ... dai đau lồn..

C .. to lo chi đói
Cơm nhà lồn.vợ
Sờ lồn.béo, đéo lồn.. gầy
Vú nẫy lồn. sưng
Ví phấn với vôi
Ví lồn. con đĩ với môi thợ kèn

Bà ba đi chợ đường quai
Vừa đi vừa tỉa lá khoai bưng lồn.

Bà ba đi chợ đường cồn
Vừa đi vừa tỉa lông lồn. bán trăm

Trên trời có ông sao Rua
L.. em tua tủa có thua chi nào.

Lông tơ lún phún mép lồn.
Lăn tăng con cá diếc lòn vào lòn ra
Cây trời có cái chỉa ba
Thương em thì hãy đem tra nó vào
Trèo lên cây khế giữa ngày
Váy thì trụt mất, lưỡi cày thò ra
Lưỡi cày ba góc chẻ ba
Muốn đem đòn gánh mà tra lưỡi cày

Trời mưa trời gió đùng đùng
Cả bầy C.. lọ mang tơi đi tìm

Cơm ăn mỗi bửa mỗi niêu
Tội gì bắt ốc cho rêu bám lồn.

Ví ví von von
Anh cho một cái, cỏng con về nhà

Thấy lồn. lạ như quạ quạ thấy gà con
Trong nhà đã có đồ chơi
Song le còn muốn của người thêm xinh

Kim mà đâm thịt thì đau
Thịt mà đâm thịt nhớ nhau suốt đời

C.. vạy thì ngoáy lồn. già
Ngoáy lui ngoáy tới chết cha lồn. già

C.. vạy thì ngoáy lồn. già
Ngoáy lui ngoáy tới nó ra nước nhờn

Gió nam non thổi lòn hang chuột
Đ.. em rồi, đ.. nữa được không em

Nhiều phân tốt lúa
Nhiều lụa tốt lồn.

L... tốt vì lụa Lúa tốt vì phân.

Vú em như quả mướp hương
Tay anh phật thủ đôi đường gặp nhau

Hơn nhau tấm áo manh quần
Cởi ra bóc trần ai cũng như ai

Lở khi ăn miếng trầu xanh
Đêm lo ngày sợ mặt xanh như chàm

L.. vàng, bẹn ngọc, đóc san hô
Chóc ngóc như đóc mồ côi

Con gái mười bảy mười ba
Đêm nằm với mẹ, khóc la đòi chồng
mẹ giận mẹ phát ngang hông:
"Đồ con chết chủ đòi chồng thâu đêm"!


Chú ý: Đồ chết chủ, địa phương ngữ, có nghĩa là mất
dạy Phát: đánh vào người bằng bàn tay xòe (phách)

Đêm bảy ngày ba vô ra không kể
Bán dạ tam bôi tửu
Bình minh sổ trản trà
Nhất nguyệt dâm nhất độ
Lương y bất đáo gia.

Dịch:
Đêm tối uống vài ba chén rượu
Sáng ra lót dạ mấy chung trà
Một lần một tháng e vừa đủ
Chắc chắn lương y khỏi tới nhà

Bảy lượt mổi ngày đòi má nó
Đương nhiên y sĩ phải xông nhà ???

Cha chết không lo, lo trâu méo lồn..

Áo xông hơi của chàng vắt mắc
Đêm em nằm em đắp lấy hơi
Trời mưa gió rét kìn kìn
Đắp đôi dãi yếm hơn nghìn chăn bông

Chuột kêu chút chít trong rương
Anh đi cho khéo đụng giường mẹ la

Chú ý: Ngày xưa cái giường của người đàn bà nhà quê là loại giường chỏng đóng bằng tre già, lâu ngày thành xiu lỏng, đụng vào đó kêu cót két, giống như tiếng chuột kêu chút chít. Có lẽ bà mẹ của cô gái kia đã một lần chợt thức giấc vì nghe tiếng chuột kêu, hoặc nghe tiếng giường kêu

Mẹ ơi con muốn lấy chồng
Con ơi mẹ cũng một lòng như con

Cô Ba, cô Bốn lấy chồng
Cô Năm ở lại giật mồng tăng tăng

Xót lòng mẹ góa con côi
Kiến ăn lần hồị lồn. lớn bằng mo

Áo dài chẳng nệ quần thưa
Bảy mươi có của cũng vừa mười lăm

Em ham giàu em lấy thằng bé tí ti
Làng trên xã dưới thiếu gì trai tơ

Ngó lên gò mả, Ngó xuống gò găng
Gặp chị bẻ măng, Trật quần bắt kiến
Thấy tôi hay liếng, Chị bảo bắt giùm
Tôi bắt một đổi, Thấy cái đùm đen thui!

Gió nam non thổi lòn hang cóc
Phận em nghèo nên mồng đóc khô rang

Gió nam tốc dải yếm đào
Sao anh trông thấy oán anh không vào thắp hương

Anh về sương gió lạnh lùng
Ở đây chung gối chung mùng với em

Anh về để áo lại đây
Đêm khuya em đắp, kẻo gió tây lạnh lùng

Đêm đông trời lạnh như đồng
Mượn chi thì cho mượn, mượn chồng thì không
Làm thân con gái phải lo
Mùa đông rét mướt ai cho mượn chồng

Thương em đút C. qua rào
Không thương rút lại gai quào rách dạ
Thương em đút C. qua rào
Tai nghe chó sủa, rút lại nên bị gai cào xướt dạ

Trăng lên đỉnh núi mu rùa
Cho anh đ. chịu đến mùa anh trả khoai

Vú em như cái chủm cau
Cho anh bóp cái có đau anh đền

Vú em đang giá một tiền
Cho anh bóp cái anh đền năm quan

Nứng L ... mà cạ cây vông
Cạ lên cạ xuống gai châm đầy lồn..

Vân Tiên ngồi dựa gốc môn
Chờ cho trăng lặn sờ lồn Nguyệt Nga
Nguyện Nga biết ý không la
Vân Tiên thấy vậy sờ ba bốn lần

Mười ba mười bốn lum săng
Mười lăm mưới sáu lông quăm mép lồn
Mười bảy mười tám thẹn thùng
Hai mươi mười chín như khùng như điên

Ra đường con mắt ngó nghiêng
Về nhà chui chốn buồng riêng vê mồng

Dậm chân xuống đất cái đùng
Vỗ L ...cái phạch chào anh hùng đến đây!

Dậm chân xuống đất kêu bon
Vọc C. cho cứng chào con nứng lồn
Bà Đội cho chí bà Cai
Bà nào hay đố chữ cũng váy ngoài lồn. trong

Nứng lồn.. đỏ mặt Nứng C... đỏ lổ tai

Sướng lỗ khu su con mắt (lỗ khu tiếng Huế là hậu môn)

Cực chi da diếc diếc da
Áo em hai vạc trải ra anh nằm

Nứng C. máu Cái lồn què

Trăng lên khuất bóng cây dừa
Làm thân con gái phải chừa đi đêm!

Thương em không dám vô nhà
Đi qua đi lại hỏi: "gà bán không?"

Em là con gái đêm hôm
Anh đừng lui tới mà nam nồm tội em!

Chú ý: Nam, nồm: gió nam, gió nồm, đây ý nói tiếng đồn xấu, tiếng chì tiếng bấc.

Thương nhau nào ngại sang giàu
Tối lửa tắt đèn nhà ngói như nhà tranh

Chị kia lớn mổng cao mu
Lại đây cho tôi gởi con cu trọc đầu
Cu tôi vừa mới đâm lông
Cho mượn cái lồng nhốt đỡ vài đêm

Cu tui ăn đậu ăn mè
Ăn chi của chị mà chị đè cu tui
Tui chưa trách chị mà chị lại trách tui
Con chị đi lên đi xuống nên con tui mang bầu

Con chị mang chín tháng không rầu
Con tui mang hai hòn dái nặng đầu quanh năm

Ôi O bán cồm hai lu
Đi mô tui gởi con cu về cùng
Cu tui tui ấp tui bồng
Chớ bỏ vào lồng mà ốm cu tui
(Tiếng Huế goi O là cô )

Thấy đua, thì cũng đua đòi
Thấy tỉa lông nách cũng xoi lông lồn.

Tham giàu lấy phải thằng Ngô
Đêm nằm như thể cành khô đâm vào

Tiếc thay con gái mười ba
Liều thân mà lấy ông già tám mươi
Tiếc thay con ngựa bạch mà thắt cái dây cương thừng
Tiếc thay con người ấy thế ma đi ôm lưng cái lão già

Tiếc thay cây mía ngọt lại sâu
Tiếc con gái tốt mà cái bím bầu không lông

Hởi cô mặc yếm hoa tầm
Chồng cô đi lính cô nằm với ai
Cô nằm cô đẻ thằng bé con trai
Chồng cô về hỏi: Con ai thế này ?
Con tôi đi kiếm về đây
Có cho nó gọi bằng thầy thì cho

Hởi cô cô yếm thắm bùa đeo
Chồng cô cô bỏ cô theo chồng người

Hỡi nàng má đỏ hồng hồng
Cổ cao, miệng rộng, lông lồn vắt vai

Hát cho chó cắn, bò lồng
Hát cho con gái bỏ chồng mà theo

Rung rinh nước chãy trên đèo
Bà già lật đật mua heo cưới chồng

Ở đây có đứa lấy trai
Cho nên trời hạn nắng hoài không mưa

Ông già ông đội nón cời
Ông ve con nít ông trời đánh ông
Ông ơi tôi chẳng lấy đâu
Ông đừng cạo mặt nhỗ râu tốn tiền

Tiện đây mận hỏi thăm đào
Vườn hồng đã có kẻ vào hay chưả
Mận hỏi thì đào xin thưa
Vườn hồng có lối nhưng chưa ai vào

Khứ nhật ngã đề xuân nhất tự
Hà nhân lai đáo phá thành thung
Lang quân bất thức lang quân hận
Tọa tất xuân đề ngọa tất thung

Ngày ấy ta đề "xuân" một chữ
Cớ sao ai lại phá thành "thung"
Bởi chàng không rõ nên chàng giận
Ngồi ắt là "xuân", nằm ắt "thung"

Ngó vô đám bắp khô bao
Muốn vô mà bẻ người ta rào tứ tung
Một mai trống thủng còn vành
Lấy da trâu bịt lại cũng lành như xưa

Đau bụng, lấy bụng mà chườm
Nhược bằng không khỏi, hắc hương với gừng

Em ơi! Trống lũng khó hàn
Dây dùng khó đứt,
người khôn khó tìm

Nước chãy hòn đá lăn cù
Con chị đã vậy thì bèn con em!

Rộng đồng thì gió thổi luôn
Khi vui cô chị khi buồn cô em

Mít ngon anh đánh cả xơ
Chị đẹp em đẹp anh sờ cả đôi

Gió đưa bụi chuối sau hè
Đã ve con chị lại tò vè con em!

Trông chồng mà chẳng thấy chồng
Để em vắng lạnh phòng không một mình

Buồn tình cha chả buồn tình
Biết ai lẻ bạn cho mình kết đôi

Quét nhà long mốt long hai
Cha mẹ đi vắng dẫn trai vô nhà

Chú ý: long mốt long hai: làm dối, quét một chổi sót một chổị Đây ý nói làm thì vụng về, chỉ giỏi đường trai gáị

Chàng vông mà đậm lúa lép
Rựa lụt mà cắt dép da
Trai tơ mà lấy vợ già
Nhai cơm mà sú thưa:"bà nuốt đi"!

Chú ý: chàng vông: chàng bằng gỗ vông, nhe..

Mèo hoang thì chó cũng hoang
Một chàng ăn trộm gặp nàng nhổ môn

Chú ý: nên hiểu theo nghĩa bóng (gian phu dâm phụ)

Cầm chài mà vải bụi tre
Con gái mười bảy đi ve ông già!

Một vợ mà xử không xong
Còn đòi hai vợ cho cong ... cái xương suờn
Từ nay sống cũng bằng không
Thôi rồi cái kiếp làm chồng làm cha

Cho dù có sống đến già
Cho dù béo tốt cũng là phí toi
Bây giờ pháo đả tịt ngòi
Gia tài còn lại ... một vòi nước trong

Củ lang nấu lộn củ mì
Cháu lấy chồng dì kêu dượng bằng anh

Xứ tôi có núi "Xách Quần"
Lấy ai thì lấy xin đừng lanh chanh
Yêu anh thì giữ lấy anh
Xin đừng ăn tỏi chê hành là hôi

Xách quần chạy ngược chạy xuôi
Chạy mỏi cẳng rồi đứng lại bơ vơ ...

Con gái chơi với con trai
Coi chừng cặp vú như hai sọ dừa

Có chồng thì mặc có chồng
Tôi đi ngủ dạo kiếm ít đồng mua rau!

Một hai họ nói rằng không
Dấu chân ai đứng bờ sông hai người

mẹ ơi mẹ bạc như gà
Con chưa lẻ mẹ, mẹ đà lẻ con

Ai về nhắn với ông câu
Cá ăn không giật để lâu mất mồi

Cam đường bóc vỏ còn the
Thấy em còn nhỏ anh ve để giành

Chú ý: cam đường: loại cam dại trái nhỏ, thường mọc dưới chân núi, mùi thơm như mùi cam, lá giống lá chanh, cây có gai như gai quít, trái chín ăn rất ngọt, trái xanh thì đắng và hơi chua

Thằn lằn tặc lưỡi mái tranh
Đôi ta còn nhỏ để giành mai sau
Bông thơm nở cạnh bìa rừng
Ong ve chưa dám đậu, lũ bướm đừng lau chau!

Cô tú kẽo kẹt cậu cai
Vợ chồng thuyền chài kẽo kẹt dưới sông

Con chim điểu nó biểu con chim huỳnh
Biểu tổ chức, biểu nhỏ, biểu mình ưng ta
Chim chuyền bụi ớt líu lo
Líu lo bụi ớt đừng cho con chim chuyền

Liệu bề dát được thì đau
Đừng gầy rồi bỏ thế gian họ đào

Trời sinh cái cửa ra vào Sao em lại khoe sắc tài
Độc bình để trống nhành mai anh cắm vào!

Chú ý: đào (đào bới): chưởi rủa

Em ơi anh bịnh nhức dầu
Hay đi đái rát lại đau ngọc hành
Thuốc gì đỏ đỏ xanh xanh
Thì em đi lấy cho anh một liều

Sáng trăng tôi được chồng ai
Tôi cột gốc xoài ai chuộc cho tôi
Ba quan tiền điếu bó mo
Con heo đóng cũi tôi cho chuộc chồng

Chú ý: Đại ý: một gã chuyên "hai hoa" bị gái ngoan bắt được trói lại rồi đánh tiếng. Quan tiền điếu bó mo: tiền đúc bằng đồng điếu, tức loại đồng tiền thau. 1 quan = 10 tiền; 1 tiền = 60 đồng. Đem những đồng tiền bó vào mo cau cho dễ mang.

Những mạng thích chí ngao du
Dạo chơi cho biết xuân thu thế nào
Nhất lê, nhì lựu, ba đào
Nhìn xem thấy cảnh muốn vào bẻ bông.
Thương cha nhớ mẹ có hồi
Thương anh lúc đứng lúc ngồi không an
Ước gì sông rộng một gang
Bắc cầu dãi yếm cho chàng sang chơi
Ước gì dãi yếm em dài
Để em buột lấy những hai anh chàng

Ai ơi chơi lấy kẻo già
Măng mọc có lứa người ta có thì
Chơi xuân kẻo hết xuân đi
Cái già xồng xộc nó thì theo sau

Chẳng ăn chẳng mặc chẳng chơi
Bo bo giử lấy của trời làm chi

Bà già đã tám mươi tư
Ngồi bên cửa sổ viết thư tìm chồng

Trai tơ lấy gái nạ dòng
Cầm bằng uống máu làng trong làng ngoài

Cô kia má đỏ hồng hồng
Cô chửa có chồng, còn đợi chờ ai

Buồng không lần lữa hôm mai
Đầu xanh mấy lúc da mồi tóc sương

Cô kia cắt cỏ bên sông
Cái váy thì cộc, cái lông thì dài
Thuyền chài nó trả quan hai
Thưa rằng chẳng bán để dài quét sân

Cổ tay em trắng lại vừa tròn
Để cho ai gối đến mòn một bên

Nghiêng tai hỏi nhỏ ông Phật rằng:
Trai thanh lấy gái có chồng được không?

Chơi cho thủng trống long bồng
Rồi ra ta sẽ lấy chồng lập nghiêm
Chơi cho thủng trống long chiêng
Rồi ra ta sẽ lập nghiêm lấy chồng

Tính quen chừa chẳng được đâu
Vạ làng, làng bắt mấy trâu mặc làng

Không chồng mà chửa mới ngoan
Có chồng mà chửa thế gian thường tình

Em mất chồng em chẳng có lo
Anh đây mất vợ nằm co một mình

Em đây là gái năm con
Chồng em rộng lượng em còn chơi xuân

Có chồng càng dể chơi ngang
Đẻ ra con thiếp con chàng con ai

Hai tay cầm lấy quả hồng
Quả chát phần chồng, quả chín phần trai

Vú sửa mà bửa làm đôi
Nữa cho con bú, nữa cho trai đem về

Đêm nằm vuốt bụng thở dài
Thương chồng thì ít thương trai thì nhiều

Mày ăn cơm hay ăn khoai
Một bài thơ ấy ngâm hai ba lần

Chử tình đáng giá ngàn vàng
Từ anh chồng củ đến chàng là năm
Còn như yêu trộm nhớ thầm
Họp chợ trên bụng đến trăm con người

Đánh tôi thì tôi chịu đau
Tánh tôi hoa nguyệt chẳng chừa được đâu

Lẳng lơ chết cũng ra ma
Chính chuyên chết cũng chôn ra ngoài đồng
Lẳng lơ cũng chẳng hao mòn
Chính chuyên cũng chẳng sơn son để dành

Cau khô mà bỏ hộp đồng
Mặt mi không xứng làm chồng tau mô

Chưa quen đi lại cho quen
Tuy rằng cửa đóng mà then không gài

Em đang bắc nước sôi sôi
Nghe anh có vợ, quăng nồi đá vung

Gặp nhau từ bến Đại Đồng
Quên nhau hay đã có chồng mà quên

Đêm đêm ngồi dưới bóng trăng
Thương cha nhớ mẹ không bằng thương anh
Đêm nằm lưng chẳng bén giường
Mong cho mau sáng ra đường gặp anh

Thương anh chẳng dám nói ra
Chiều chiều đi dạo vườn hoa khóc ràn
Đêm nằm khô héo lá gan
Mong cho mau sáng ra đàng gặp anh

Ngó lên trăng chúc sao nghiêng
Vui chung với bạn sầu riêng một mình

Ngồi buồn nghĩ càng thấm
Hột cơm tấm cắn làm hai
Rau lang đỡ bữa liễu với mai đừng lìa
Em với anh như khóa với chìa
Đừng để cho ống liệt, khóa với chìa lìa nhau

Chú ý: bụng ống khóa bị hư

Bóng trăng ngã lộn bóng tre
Xin chàng đứng lại mà nghe thiếp thề

Vườn đào, vườn lựu vườn lê
Bởi người lấy nhụy buớm xê ra ngoài

Nghĩ mình lại giận lấy mình
Ao chưa đậu sống rập rình tra khuy

Chú ý: Đậu sống: Ao chưa may đường sống lưng

Đèn hết dầu đèn tắt
Nhang hết vị hết thơm
Anh đừng lên xuống đêm hôm
Để thế gian đàm tiếu tiếng bấc tiếng nồm tội em

Tay cầm cọng lạc bẻ cò
Lòng thương da diết, giả đò làm lơ
Thương sao thương dại thương khờ
Trong nhà không dám khóc, ra bụi bờ khóc than

Hai tay vin lầy đòn rồng
Tội trời con chịu theo chồng con cứ theo
Ra đi cha mắng mẹ rầy
Không đi thì sợ ngoài này anh trông

Con cu bay bổng qua sông
Hỏi thăm cô đó có chồng hay chưả
Có chồng năm ngoái ngày xưa
Năm nay chồng để như chưa có chồng

Đói lòng ăn trái khổ qua
Nuốt vô thì đắng, nhả ra bạn cười
Bạn cười thì mặc bạn cười
Tháng năm đi cưới tháng muời có con

Có con nên phải thua người
Mắc cho con bú, mắc cười với con.

Đang khi lửa tắt cơm sôi
Lợn kêu con khóc chồng đòi tòm tem
Bây giờ lửa đã cháy lên
Lợn no con nín, tòm tem thì tòm
* Tục ngữ phong dao (trích "Tục Ngữ Phong Dao" của Nguyễn văn Ngọc) Ca dao

Ba bà đi chợ đường quai,
Vừa đi, vừa tỉa lá khoai bưng lồn
Ba bà đi chợ đường cồn
Vừa đi vừa tỉa lông lồn bán trăm.

Nước nóng đổ lọ bình vôi
Tôi ngồi tôi nghĩ bố tôi, tôi buồn
Bố tôi dở dại dở khôn,
Say mê cái lồn bỏ mẹ con tôị

Câu đố:
Ba bà mà giang chân ra
Một ông đứng giữa mà tra C. vàọ
(ba ông đầu rau và nồi cơm)

Ba ông ngồi ghế
Một ông cậy thế,
Một ông cậy thần
Một ông tần ngần đút C. vào bếp.
(Bể thổi lửa)

Bì bà, bí bạch chân cò
Bí ba bí bách, nằm co giữa giường
Đoạn rồi sờ vú sờ sườn
Sờ sao cho nó đỡ buồn mà thôị
(Bánh dầy)

Bốn chân chong chóng, hai bụng kề nhau
Cắn giữa phau câu, nghiến đi nghiến lại.
(cối xay)

Bốn chân mà lại có đuôi
Đầu như đầu c., lưng lại gù lưng.
(con chuột)

Cái gì vừa quả vừa hoa,
Con nít cũng thích ông già cũng mê
Ra đường dù thấy tràn trề
Ngắm nhìn thì được, mân mê thì đừng
(hai "quả đào tiên").

Cái hoa tim tím, cái nhị điều đều,
Đàn ông đâm nhiều, đàn bà đâm ít.
(cái máy khâu)

Canh một thì trải chiếu ra,
Canh hai bóp vú, canh ba sờ lồn
Canh tư thì lắc om sòm
Canh năm cuộn chiếu ẳm con ra về.
(Người kéo vó)

Chấm chấm mút mút đút vào lỗ trôn,
Hai cái lông lồn cái dài cái ngắn.
(xỏ kim)

Chưa chết đã đem đi chôn
Chưa ra đầu ngõ, vạch lồn xem ghe.
(Người cầm bó rơm xin lửa)

Chưa hỏi đã cưới liền tay
Bức chí ta nên phải lấy mày
Đêm nằm tơ tưởng sờ cùng mó
Mó đến mày, lại sướng đến ta.
(cái quạt)

Gầy gò có bốn cái xương
Cái giải thòng thơng vướng anh c. dàị
(Quả nhãn)

Già thì đặc bí bì bì
Con gái đương thì rỗng toách toành toanh.
(cau lúc già và lúc là cau hoa)

Lồm xồm hai mép những lông
Ở giữa có lỗ đàn ông chui vào
Chui vào rồi lại chui ra
Năm thì mười họa đàn bà mới chui.
(Cái áo tơi)

Già ăn với cà kheo
Lại thêm c. lõ, lại đèo nắm lông.
(Miếng giầu thuốc)

LỒN già da dính tận xương
Váy xanh mỏng mảnh lại thương c. dài.
(Cối giã gạo)

Lù lù như mu lồn chị
Lị xị như đầu c. tôi
Ngày n_ đi khắp mọi nơi
Đến đêm lại chui vao mu lồn chi..
(Con rùa)

Lưng tròn đít lại bảnh bao
Mân mân mó mó đút n_ vào
Thủy hỏa âm dương sôi sình sịch
Âm dương nhị khí sướng làm saọ
(điếu thuốc lào)

Mình bằng quả chuối tiêu
LỒN bằng vỏ trấu, lổ bằng niêụ
(Con chuột)

Mình tròn, da lại trắng tinh
Hể nóng đến mình thì ưỡn vú ra
Ăn phải thịt gà lại tịt vú đị
(bánh đa sát-kê)

Mình tròn trùng trục, đầu toét toè loe
Đút vào con gái, cô con gái nghe,
Đút vào bà lão, bà lão lắc.
(đôi hoa tai)

Người thì cao lớn trượng phu
Đóng mười lần khố, trật cu ra ngoàị
(cây chuối có hoa)

Rành rành ba góc, giữa con cóc ngồi
Hai bên thiên lôi, hai bên địa võng.
(hai cái vú)

Rau âm phủ nấu với mủ lồn tiên
Ngựa cửa quyền nấu với ả lồn tranh.
(Măng nấu với rươi, cua nấu với khế)

Thoạt vào thì vén váy lên
Cái dưới mấp máy, cái trên gật gù
(dệt cửi)

Trên lông dưới lông,
tối lồng làm một
(con mắt)

Vừa bằng cổ tay đâm n_ vô lồn
Gặp ông quan ôn, bỏ lồn mà chạỵ
(Con chuột và con mèo)

Tục ngữ phong dao

Anh em bất nghĩa chi tồn
Anh đánh miếng lồn em đánh miếng gh.
Anh em bất nghĩa chi khoèo
Anh thì đ. mèo, em lại cầm đuôị

Bủng người tươi đ.
Ba chiếc sóng cồn, mấy cái lông lồn rụng sa.ch.

Bà cốt đánh trống long tong
Nhảy lên nhãy xuống con ong đốt lồn

Bà đội cho chí bà cai
Bà nào hay đố chữ cũng lồn ngoài, váy trong.

C. ai vừa mũi người ấy.

Của lồn, lồn đòi, của c., c. quên.

Có lồn thì giữ,
C. ông hay chữ đi đêm.

Con mày con nuôi chẳng bằng con c. làm ra

Chơi no bỏ gio vào đ.
Chồng chết còn chửa hết tang
LỒN đà ngấm ngáp như mang cá mè.

Đánh đĩ gặp năm toi c.
Đĩ có tông, ai giồng nên đĩ
Đủn đỡn như đĩ được cái đanh.
Đẻ con khôn mát lồn rời rợi
Đẻ con dại thảm hại cái lồn

Đi sau ăn rau bà đẻ,
Ăn giẻ chùi trôn, ăn lồn chấm muốị

Đĩ xơ, đĩ xác, đĩ xạc, đĩ xờ
Đĩ ở trên bờ, đĩ lặn xuống aọ

Gà Tò, lợn Tó, vó Vạn Đồn,
lồn Cổ Am, c. Hành Thiện.

Gái đâu có gái lạ đời,
Chỉ còn thiếu một ông trời không chim.

Giữ được đằng trôn, đằng lồn quạ mổ.
Trai thấy lồn lạ như quạ thấy gà con.

Già thì già tóc, già tai,
Già răng già lợi, đồ chơi không già.

LỒN rằng lồn chẳng sợ ai,
Sợ thằng say rượu, đ. dai đau lồn

Lưỡi không xương nhiều đường lắt léo
lồn không cạp, lồn méo làm bạ

Mưu con đĩ, trí học trò.
May hơn khôn, lớn lồn hơn đẹp.
Nuôi con chẳng biết tính con
Hể vú gai gạo thì lồn chớp đông.

Nứng c. thì vặc đến nhà
LỒN còn đau mắt không ra đến ngoàị

No cơm ấm cật dậm dật mọi nơi
Quần áo tả tơi mọi nơi chẳng dật.

Nằm đất hàng hương còn hơn nằm hàng cá
LỒN cô hàng cá còn nhẵn hơn má anh chàng hương.

Nhăn nhở như lồn lở sơn.
Quang không lành, mắng giành không trơn
LỒN không lành, mắng quanh hàng xóm.
Rền rĩ như đĩ phải tim lạ

Ra đường ai nói thế nào
Về nhà lấy thớt lấy dao băm lồn
Thấy đua thì cũng đua đòi
Thấy tỉa lông nách, cũng xoi lông lồn

Trân trân như lồn trần không đáỵ
Uống rượu ngồi dai, dái mài xuống đất.

Văn chương chữ nghĩa bề bề,
Thần lồn ám ảnh cũng mê mẫn nguờị
Xót lòng mẹ góa con côi
Kiếm ăn lần hồi, lồn lớn bằng mo.

[Sưu tầm]


"""
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fillData()
    }
    
    private func prepareForViewController() {
        if let extraBold = PlayfairDisplayFont.extraBold(with: 20) {
            let titleLabel = UILabel()
            titleLabel.text = "Cai Dat"
            titleLabel.font = extraBold
            titleLabel.textColor = UIColor.random
            view.layout(titleLabel)
                .centerX().topSafe()
            //            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColorUIColor.random, NSAttributedString.Key.font: extraBold]
            
            
            let image = UIImage(named: "oldBookBackGroundImage")
            
            view.layout(imageView)
                .top().left().bottom().right()
            
            image?.prepareForDisplay { [weak self] preparedImage in
                DispatchQueue.main.async {
                    self?.imageView.image = preparedImage
                }
            }
        }
        
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
        
        contentView.layout(contentLabel)
            .top(16).left(16).right(16).bottomSafe(16)
        
    }
    
    func fillData() {
        let medium = R.font.playfairDisplayMedium(size: 20)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.firstLineHeadIndent = 5.0
        paragraphStyle.lineSpacing = 6
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: medium as Any,
            .foregroundColor: UIColor.random,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedQuote = NSAttributedString(string: text, attributes: attributes)
        
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .left
        contentLabel.attributedText = attributedQuote
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
