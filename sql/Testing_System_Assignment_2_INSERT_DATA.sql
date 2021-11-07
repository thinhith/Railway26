-- INSERT dữ liệu vào bảng--
-- deppartment table--
USE testing_system2;
INSERT INTO department (department_name)
VALUES					('A1'),
						('A2'),
                        ('A3'),
                        ('A4'),
                        ('A5');
                        
-- position table --
INSERT INTO position (position_name)
VALUES					('Dev'),
						('QA'),
                        ('Teser'),
                        ('PM'),
                        ('Scrum Mater'),
                        ('pool');

-- Account table--
INSERT INTO `account` 
(email, 							username, 							fullname, 					department_id, 			position_id)
VALUES				
('phamvanthuog70@gmail.com'		,	'phamvanthuog70'		, 		'Phạm Văn Thượng'		, 				1,					2),
('vungoanmori@gmail.com'		,	'vungoanmori'			, 		'Vũ Thị Ngoan'			,				2,					4),
('Starlee9009@gmail.com'		,	'Starlee9009'			,		'Nguyễn Thuỵ Kiều Liên'	,				3,					2),
('mrledung.imjapan@gmail.com'	,	'mrledung.imjapan'		,		'Lê Trí Dũng'			,				5,					2),
('chuongnguyen.dc@gmail.com'	,	'chuongnguyen.dc'		,		'Nguyễn Minh Chương'	,				3,					5),
('thinh.ithp@gmail.com'			,	'thinh.ithp'			,		'Nguyễn Quang Thịnh'	,				1,					4),
('chocolateTran2805@gmail.com'	,	'chocolateTran2805'		,		'Trần Thúy An'			,				3,					4),
('704.kimthanh@gmail.com'		,	'704.kimthanh'			,		'Nguyễn Thị Kim Thanh'	,				3,					5),
('phamvansam0@gmail.com'		,	'phamvansam0'			,		'Phạm Văn Sâm'			,				3,					1),
('vinhjp996@gmail.com'			,	'vinhjp996'				,		'Nguyễn Trường Vinh'	,				5,					4),
('bao.lengoc98@gmail.com'		,	'bao.lengoc98'			,		'Lê Ngọc Bảo'			,				5,					4),
('hanakin8668@gmail.com'		,	'hanakin8668'			,		'Trần Hồng Việt'		,				5,					4);

-- Group table--
INSERT INTO `group` (group_name, creator_id)
VALUES				('Group1',		1),
					('Group2',		3),
					('Group3',		5),	  
					('Group4',		4),
					('Group5',		6),
					('Group6',		9),
					('Group7',		8),
					('Group8',		2),
                    ('Group9',		2);
-- Tại sao lại không thể lập tên với tên là Group 01

-- Group account--
-- Group 1 thuộc A1 thì trưởng nhóm này phải thuộc A1.--
-- group_id = 1 là trong group Group1_A1 thì:--
-- tất cả thành viên phải thuộc A1.--
-- Nhớ phải điền giá trị ID của trưởng nhóm--
INSERT INTO groupaccount 
(group_id, account_id)
VALUES
(1		,		1),
(1		,		2),
(2		,		3),
(2		,		5),
(2		,		6),
(3		,		5),
(3		,		3),
(3		,		4),
(4		,		4),
(4		,		5),
(4		,		3),
(5		,		6),
(5		,		3),
(5		,		2),
(6		,		9),
(6		,		2),
(6		,		3),
(7		,		8),
(7		,		3),
(7		,		9),
(8		,		2),
(8		,		3),
(8		,		1),
(8		,		4);

--  Type question table
INSERT INTO typequestion (type_name)
VALUES					('easay'), -- tự luận
						('multiple-choice)'); -- trắc nghiệm

--  categoryquestion table
INSERT INTO categoryquestion (category_name)
VALUES							('Java'),
								('NET'),
								('SQL'), 
								('Postman'), 
								('Ruby');
            
-- ở trên đã chọn Hàm ENUM thì có nhất thiết phải INSERT dữ liệu hay không.

-- question table
INSERT INTO question (content, 														category_id, 			type_id, 			creator_id)
VALUES				('SQL là gì', 														3,					2,					3),
					('Câu lệnh để chọn tất cả bản ghi từ table', 						3,					2,					3),
                    ('Định nghĩa JOIN và các loại JOIN', 								3,					2,					3),
                    ('Cú pháp để thêm bản ghi vào 1 bảng là gì', 						3,					2,					3),
                    ('Làm thế nào để bạn thêm 1 cột vào 1 bảng', 						3,					2,					3),
                    ('Xác định câu lệnh Delete SQL', 									3,					2,					3),
                    ('Xác định COMMIT', 												3,					2,					3),
                    ('Khóa chính (PRIMARY KEY) là gì', 									3,					2,					3),
                    ('Khóa ngoại (FOREIGN KEY) là gì',									3,					2,					4),
					('CHECK Constraint – Ràng buộc CHECK là gì',						3,					2,					5),
					('Một bảng có thể có nhiều hơn một khóa ngoại không',				3,					2,					4),
					('SQL là từ viết tắt của',											3,					1,					2),
                    ('Câu lệnh SQL nào được dùng để trích xuất dữ liệu từ database',	3,					1,					2),
                    ('Câu lệnh SQL nào được dùng để cập nhật dữ liệu từ database'	,	3,					1,					2),
                    ('Câu lệnh SQL nào được dùng để chèn thêm dữ liệu vào database'	,	3,					1,					2),
                    ('Làm thế nào để chọn cột dữ liệu có tên Firs.tName từ bảng Persons',3,					1,					2),
                    ('Làm thế nào để chọn tất cả các cột dữ liệu trong bảng Persons',	3,					1,					2),
                    ('Bạn hãy cho biết sự khác nhau giữa các process và các threads', 	1,					1,					3),
                    ('Bạn hãy giải thích ngắn gọn các trạng thái có thể có của một luồng',	1,				1,					2),
                    ('Deadlock là gì',													1,					1,					2),
                    (' Iterator là gì trong Java',										1,					1,					2),
                    ('Bạn hãy giải thích sự khác nhau giữa Iterator và ListIterator',	1,					1,					2),
                    ('Bạn hãy cho biết sự khác nhau giữa fail-fast và fail-safe?',		1,					1,					2),
                    ('Đâu là câu Sai về ngôn ngữ Java',									1,					2,					2),
                    ('Đâu không phải là một kiểu dữ liệu nguyên thuỷ trong Java',		1,					2,					2),
                    ('Phương thức next() của lớp Scanner dùng để làm gì?',				1,					2,					2),
                    ('Muốn chạy được chương trình Java, chỉ cần cài phần mềm nào sau đây?',	1,					2,					2),
                    ('Gói nào trong Java chứa lớp Scanner dùng để nhập dữ liệu từ bàn phím',1,					2,					2),
                    ('Phương thức nextLine() thuộc lớp nào',								1,					2,					2);
                 
                    
                    
                        
-- Answer table
INSERT INTO answer (content, 																									questionid, 	iscorrect)
VALUES				('Viết tắt của – ngôn ngữ truy vấn cấu trúc',																	1,			'TRUE'),
					('Cú pháp: Select * from table_name',																			2,			'TRUE'),
					('INNER JOIN,SELF JOIN,CROSS JOIN,FULL OUTER JOIN,RIGHT OUTER JOIN,LEFT OUTER JOIN',							3,			'TRUE'),
                    ('Sử dụng cú pháp INSERT để thêm bản ghi vào 1 bảng',															4,			'TRUE'),
                    ('ALTER TABLE table_name ADD (column_name)',																	5,			'TRUE'),
                    ('Sử dụng câu lệnh:DELETE FROM table_name<br>WHERE<Condition>',													6,			'TRUE'),
                    ('COMMIT lưu lại tất cả các thay đổi được thực hiện bởi các câu lệnh DML',										7,			'TRUE'),
                    ('Khóa chính là cột có các giá trị xác định duy nhất mỗi hàng trong một bảng',									8,			'TRUE'),
                    ('Khi một trường khóa chính của một bảng được thêm vào các bảng',												9,			'TRUE'),
                    ('Một ràng buộc CHECK được sử dụng để giới hạn các giá trị',													10,			'TRUE'),
                    ('Một bảng có thể có nhiều hơn một khóa ngoại nhưng chỉ có một khóa chính',										11,			'TRUE'),
                    ('Strong Question Language',																					12,			'FALSE'),
                    ('Structured Question Language',																				12,			'FALSE'),
                    ('Structured Query Language',																					12,			'TRUE'),
                    ('Get',																											13,			'FALSE'),
                    ('Open',																										13,			'FALSE'),
                    ('Extract',																										13,			'TRUE'),
                    ('Select',																										13,			'FALSE'),
                    ('Update',																										14,			'FALSE'),
                    ('Save us',																										14,			'FALSE'),
                    ('Modify',																										14,			'TRUE'),
                    ('Save',																										14,			'FALSE'),
                    ('Add recrd',																									15,			'FALSE'),
                    ('Add into',																									15,			'FALSE'),
                    ('Insert',																										15,			'TRUE'),
                    ('Add new',																										15,			'FALSE'),
                    ('Extract FirsName From Persons',																				16,			'FALSE'),
                    ('Select FirstName From Persons',																				16,			'TRUE'),
                    ('Select persons.FirstName',																					16,			'FALSE'),
                    ('Select [all] FROM Persons',																					17,			'FALSE'),
                    ('Select All Persons',																							17,			'FALSE'),
                    ('Select *.Persons',																							17,			'TRUE'),
                    ('Select * FROM Persons',																						17,			'FALSE'),
                    ('Một process là một quá trình thực thi của một chương trình trong khi Thread (Luồng)',							18,			'True'),
                    ('Trong quá trình thực thi, một thread có thể có các trạng thái',												19,			'True'),
                    ('Deadlock là khi có hai processes mà process này chờ cho process kia thực thi xong trước khi tiếp tục',		20,			'True'),
                    ('Iterator trong Java là một interface được sử dụng để thay thế Enumerations trong Java',						21,			'True'),
                    ('Một  Iterator có thể được dùng để duyệt các Set và List collections, trong khi',								22,			'True'),
                    ('Thuộc tính fail-safe của Iterator hoạt động với bản sao của collection bên dưới',								23,			'True'),
                    ('Ngôn ngữ Java có phân biệt chữ hoa - chữ thường',																24,			'False'),
                    ('Java là ngôn ngữ lập trình hướng đối tượng',																	24,			'TRUE'),
                    ('Dấu chấm phẩy được sử dụng để kết thúc lệnh trong Java',														24,			'FALSE'),
                    ('Chương trình viết bằng Java chỉ có thể chạy trên hệ điều hành Window',										24,			'FALSE'),
                    ('Double',																										25,			'FALSE'),
                    ('int',																											25,			'FALSE'),
                    ('long',																										25,			'FALSE'),
                    ('long float',																									25,			'TRUE'),
                    ('Nhập1 số nguyên',																								26,			'TRUE'),
                    ('Nhập một ký tự',																								26,			'FALSE'),
                    ('Nhập một chuỗi',																								26,			'FALSE'),
                    ('Không có phương thức nào',																					26,			'FALSE'),
                    ('Netbeans',																									27,			'FALSE'),
                    ('Eclipse',																										27,			'FALSE'),
                    ('JDK',																											27,			'FALSE'),
                    ('Java Platform',																								27,			'TRUE'),
                    ('java.net',																									28,			'FALSE'),
					('java.io',																										28,			'FALSE'),
					('java.util',																									28,			'TRUE'),
					('java.awt',																									28,			'FALSE'),
                    ('String',																										29,			'FALSE'),   
                    ('Scanner',																										29,			'FALSE'),
                    ('Integer',																										29,			'TRUE'),
                    ('System',																										29,			'FALSE');
                    
-- Exam table
INSERT INTO exam (`code`, 		tittle, 				category_id, creator_id, duration)
VALUES			('SQL01',		'Đề thi SQL01',				3,			5,			120),
				('SQL02',		'Đề thi SQL02',				3,			3,			100),
				('SQL03',		'Đề thi SQL03',				3,			5,			90),
				('Java01',		'Đề thi Java01',			1,			3,			60),
				('Java02',		'Đề thi Java02',			1,			5,			30),
                ('Java03',		'Đề thi Java03',			1,			5,			30),
                ('NET01',		'Đề thi NET01',				2,			4,			30),
                ('NET02',		'Đề thi NET02',				2,			3,			30),
                ('NET03',		'Đề thi NET03',				2,			3,			30),
                ('Postman01',	'Đề thi Postman01',			4,			3,			30),
                ('Postman02',	'Đề thi Postman02',			4,			4,			60),
                ('Postman03',	'Đề thi Postman03',			4,			8,			100),
                ('Ruby01',		'Đề thi Ruby01',			5,			8,			100),
				('Ruby02',		'Đề thi Ruby02',			5,			9,			90),
				('Ruby03',		'Đề thi Ruby03',			5,			7,			60);
-- examquestion
INSERT INTO examquestion (exam_id, question_id)
VALUES						(1	,		1),
							(1	,		2),
                            (2	,		3),
                            (3	,		2),
                            (4	,		20),
                            (5	,		19),
                            (6	,		10);