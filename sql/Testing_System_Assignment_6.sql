USE testing_system2;
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
SELECT a.account_id, a.username,d.department_name
FROM department d
INNER JOIN `account` a ON d.department_id = a.department_id
WHERE department_name = 'A1';

DROP PROCEDURE IF EXISTS account_of_de;
DELIMITER $$
CREATE PROCEDURE account_of_de
(IN in_department_name VARCHAR(50))
BEGIN
	SELECT a.account_id, a.username 
	FROM department d
	INNER JOIN `account` a ON d.department_id = a.department_id
	WHERE department_name = in_department_name;
END $$
DELIMITER $$
CALL account_of_de('A1');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
-- OUT	group_name. count(account)
SELECT g.group_name, count(ga.account_id)
FROM groupaccount ga
INNER JOIN `group` g ON ga.group_id = g.group_id
GROUP BY g.group_id;

DROP PROCEDURE IF EXISTS acc_of_group;
DELIMITER $$
CREATE PROCEDURE acc_of_group ()
BEGIN
	SELECT g.group_name, count(ga.account_id) AS SL
	FROM groupaccount ga
	INNER JOIN `group` g ON ga.group_id = g.group_id
    GROUP BY g.group_id;
    END $$
DELIMITER $$;
CALL acc_of_group ();

-- Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại

SELECT tq.type_name, count(q.questionid)
FROM typequestion tq
LEFT JOIN question q ON q.type_id = tq.type_id
WHERE month(q.createdate) = month(now()) AND year(createdate) = year(now())
GROUP BY tq.type_name;

DROP PROCEDURE IF EXISTS ques_of_type;
DELIMITER $$
CREATE PROCEDURE ques_of_type ()
BEGIN
	SELECT tq.type_name, count(q.questionid)
	FROM typequestion tq
	LEFT JOIN question q ON q.type_id = tq.type_id
	WHERE month(q.createdate) = month(now()) AND year(createdate) = year(now())
	GROUP BY tq.type_name;
END $$
DELIMITER $$ ; 
CALL ques_of_type();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
SELECT tq.type_name, count(q.type_id)
FROM question q
JOIN typequestion tq ON tq.type_id = q.type_id
group by q.type_id
HAVING count(q.type_id) = (SELECT MAX(SL) FROM (SELECT count(questionid) AS SL
										FROM question
											group by type_id
												HAVING count(questionid)) AS temp) ; 
DROP PROCEDURE IF EXISTS so_luong_cau_hoi_nhieu_nhat;
DELIMITER $$
CREATE PROCEDURE so_luong_cau_hoi_nhieu_nhat ()
BEGIN
	SELECT tq.type_id, count(q.type_id)
	FROM question q
	LEFT JOIN typequestion tq ON tq.type_id = q.type_id
	group by q.type_id
	HAVING count(q.type_id) = (SELECT MAX(SL) FROM (SELECT count(questionid) AS SL
										FROM question
											group by type_id
												HAVING count(questionid)) AS temp) ;  
END $$
DELIMITER $$;
CALL so_luong_cau_hoi_nhieu_nhat();

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question

CREATE VIEW v_max_ques AS (
SELECT count(questionid) AS SL
FROM question
GROUP BY type_id);
DROP PROCEDURE IF EXISTS so_luong_cau_hoi_nhieu_nhat_1;
DELIMITER $$
CREATE PROCEDURE so_luong_cau_hoi_nhieu_nhat_1 (OUT out_id TINYINT UNSIGNED)
BEGIN
	SELECT q.type_id,tq.type_name, count(q.questionid) 
	FROM question q
    INNER JOIN typequestion tq ON q.type_id = tq.type_id
	group by type_id
	HAVING count(q.questionid) = (SELECT MAX(SL) FROM v_max_ques)  ;  
END $$
DELIMITER $$;
SET @v_out_id = '';
CALL so_luong_cau_hoi_nhieu_nhat_1(@v_out_id );
SELECT @v_out_id;

DROP FUNCTION IF EXISTS type_id;
DELIMITER $$
CREATE FUNCTION type_id 
(in_type_id SMALLINT UNSIGNED)
RETURNS SMALLINT UNSIGNED
BEGIN
DECLARE v_type SMALLINT UNSIGNED;
SELECT type_name INTO v_type
	FROM typequestion 
    WHERE type_id = type_id;
    RETURN v_type;
    END $$
    DELIMITER $$ ;
    SELECT type_name
    from typequestion
    where type_id = type_id ;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào
-- CÁCH 1:
DROP PROCEDURE IF EXISTS print_group_name_or;
DELIMITER $$
CREATE PROCEDURE print_group_name_or
(IN in_string VARCHAR(50))
BEGIN
SELECT group_name
FROM `group`
WHERE group_name LIKE CONCAT ('%',in_string,'%');

SELECT username
FROM `account`
WHERE username LIKE CONCAT ('%',in_string, '%' );

END $$

DELIMITER $$
CALL print_group_name_or('g');

-- CÁCH 2:
DROP PROCEDURE IF EXISTS sp_tim_kiem_grop_or_name;
DELIMITER $$
CREATE PROCEDURE sp_tim_kiem_grop_or_name
(IN in_nhap_chu VARCHAR(50), IN in_nhap_so TINYINT UNSIGNED)
BEGIN 
	IF in_nhap_so = 1 THEN  -- nếu thì
		SELECT 'ban dang tim kiem tên group';
		SELECT group_name
		FROM `group`
		WHERE group_name LIKE CONCAT ('%',in_nhap_chu,'%');
    ELSEIF 	in_nhap_so = 2 THEN
		SELECT 'ban dang tim kien user';
		SELECT username
		FROM `account`
		WHERE username LIKE CONCAT ('%',in_nhap_chu, '%' );
	ELSE
		SELECT 'moi ban nhap dung gia tri';
	END IF;
END $$
DELIMITER $$;
CALL sp_tim_kiem_grop_or_name ('a',1);
-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi positionID: sẽ có default là developer departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DROP PROCEDURE IF EXISTS sp_create_account;
DELIMITER $$
CREATE PROCEDURE  sp_create_account
(IN in_fullname VARCHAR(50), 
IN in_email VARChAR(50))
BEGIN 
	DECLARE v_user_name VARCHAR(30); -- tạo biến cho giá trị substring để đưa vào cấu trúc 
    DECLARE v_position_id TINYINT UNSIGNED;
    DECLARE v_department_name TINYINT UNSIGNED;
    
	SELECT SUBSTRING_INDEX(in_email, '@',1) INTO v_user_name ; -- lấy sau @
    
    SELECT position_id INTO v_position_id
    FROM `position` 
    WHERE position_name = 'Dev';
    
    SELECT department_id INTO v_department_name
    FROM department
    WHERE department_name = 'Phòng chờ';
    
	INSERT INTO `account`(email, 	username, 	fullname, 	department_id, 		position_id)
    VALUES				(in_email,v_user_name,in_fullname,	v_department_name,	v_position_id);
END $$
DELIMITER $$ ;
CALL sp_create_account ('Từ Hồng Hạnh', 'hanhth.ftu@gmail.com');
SELECT * FROM `account`;


-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
-- B1 xác định output. 		type_name	length(q.content)
SELECT  tq.type_name,length(q.content)
	FROM typequestion tq
	INNER JOIN question q ON q.type_id = tq.type_id
	WHERE length(q.content) = (SELECT MAX(length(content))
											FROM question
                                                ); 
--
--


DROP PROCEDURE IF EXISTS length_type_question;
DELIMITER $$
CREATE PROCEDURE length_type_question
(IN in_type_name ENUM('easay','multiple-choice'))
BEGIN
	IF in_type_name = 'easay' THEN
		SELECT ' ban dang tim kiem trong bo cau hoi tu luan';
		SELECT q.content, length(q.content)
		FROM question q
        INNER JOIN typequestion tq ON q.type_id = tq.type_id
        WHERE tq.type_id = 1
        group by q.questionid
        HAVING length(q.content)= (SELECT MAX(length(content))
											FROM question
                                                ); 
	
    ELSEIF in_type_name = 'multiple-choice'THEN
		SELECT 'ban dang tim kiem trong bo cau hoi trac nghiem';
		SELECT q.content, length(q.content)
		FROM question q
        INNER JOIN typequestion tq ON q.type_id = tq.type_id
        WHERE tq.type_id = 2
        group by q.questionid
        HAVING length(q.content)= (SELECT MAX(length(content))
											FROM question
                                                ); 
   ELSE 
		SELECT 'Xin vui long nhap dung gia tri';
	END IF;



END $$
	DELIMITER $$		 ;
    CALL length_type_question('easay');
    -- test


-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS delete_exam;
DELIMITER $$
CREATE PROCEDURE delete_exam
(IN in_exam_id TINYINT UNSIGNED)
BEGIN
-- b1: xoá bảng con
	DELETE FROM examquestion
    WHERE	exam_id = in_exam_id;
-- b2: xoá bảng cha
	DELETE FROM exam
    WHERE exam_id = in_exam_id;
END $$
DELIMITER $$ ;


-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
DROP PROCEDURE IF EXISTS seach_exam;
DELIMITER $$
CREATE PROCEDURE seach_exam ()
BEGIN
	WITH id_of_3_years AS (
    SELECT exam_id
    FROM exam
    WHERE  (YEAR(NOW() - YEAR(createdate))) > 3)
    
    
    DELETE FROM exam
    WHERE exam_id = (SELECT * FROM id_of_3_years );
END $$
DELIMITER $$ ;

-- cách 2
-- đếm số lượng bản ghi trước khi thao tác
SELECT count(exam_id)
FROM exam
WHERE createdate >= DATE_SUB(NOW(), INTERVAL 2 MONTH);

DROP PROCEDURE IF EXISTS _seach_exam_2;
DELIMITER $$
CREATE PROCEDURE _seach_exam_2 ()
BEGIN
	DECLARE v_number_delete_from_exam_question INT UNSIGNED;
    DECLARE v_number_delete_from_exam INT UNSIGNED;
    
    SELECT count(exam_id) INTO v_number_delete_from_exam_question
    FROM examquestion 
       WHERE exam_id IN (SELECT exam_id
						FROM exam
						WHERE createdate >= DATE_SUB(NOW(), INTERVAL 2 MONTH));
                        
	DELETE FROM examquestion
    WHERE exam_id IN (SELECT exam_id
						FROM exam
						WHERE createdate >= DATE_SUB(NOW(), INTERVAL 2 MONTH));
	-- SELECT row_count(); - trả về số lượng bản ghi vừa thay đổi trong datebase
                        
	SELECT CONCAT('Số lượng bản ghi bị xoá trong bảng exam_question: ', v_number_delete_from_exam_question);
	
	SELECT count(exam_id) INTO v_number_delete_from_exam
	FROM exam
	WHERE createdate >= DATE_SUB(NOW(), INTERVAL 2 MONTH);

	DELETE FROM exam
    WHERE createdate >= DATE_SUB(NOW(), INTERVAL 2 MONTH);
    
    SELECT CONCAT('Số lượng bản ghi bị xoá trong bảng exam: ', v_number_delete_from_exam);
END $$

DELIMITER $$
CALL _seach_exam_2();
-- ------------------------
-- Cách 2 - 2 sử dụng row_count để in bản ghi
DROP PROCEDURE IF EXISTS _seach_exam_2;
DELIMITER $$
CREATE PROCEDURE _seach_exam_2 ()
BEGIN
	DECLARE v_number_delete_from_exam_question INT UNSIGNED;
    DECLARE v_number_delete_from_exam INT UNSIGNED;
    
                        
	DELETE FROM examquestion
    WHERE exam_id IN (SELECT exam_id
						FROM exam
						WHERE createdate >= DATE_SUB(NOW(), INTERVAL 2 MONTH));
	 SELECT ROW_COUNT(); -- trả về số lượng bản ghi vừa thay đổi trong datebase luôn ảnh hưởng đến dữ liệu ngay trước nó.
                        
	SELECT CONCAT('Số lượng bản ghi bị xoá trong bảng exam_question: ', ROW_COUNT());
	

	DELETE FROM exam
    WHERE createdate >= DATE_SUB(NOW(), INTERVAL 2 MONTH);
     SELECT ROW_COUNT();
    
    SELECT CONCAT('Số lượng bản ghi bị xoá trong bảng exam: ', ROW_COUNT());
END $$

DELIMITER $$
CALL _seach_exam_2();
-- -------------------------------------------------------
-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS update_and_delete_account_of_dep;
DELIMITER $$
CREATE PROCEDURE update_and_delete_account_of_dep
(IN in_departname_name VARCHAR(50) )
BEGIN
		UPDATE `account`
		SET department_id = 6
		WHERE department_id = (SELECT department_id
							FROM department
                            WHERE department_id = in_departname_name);
		DELETE FROM department
        WHERE department_name = in_departname_name;
END $$
DELIMITER $$ ;
CALL update_and_delete_account_of_dep ('A1');
-- CÁCH 2
DROP FUNCTION IF EXISTS fn_them_depart;
DELIMITER $$
CREATE FUNCTION fn_them_depart
( in_departname_name VARCHAR(50) )
RETURNS TINYINT UNSIGNED
DETERMINISTIC
BEGIN
 DECLARE v_depment TINYINT UNSIGNED;
	SELECT department_id INTO v_depment
    FROM department
    WHERE department_name = in_departname_name;
    RETURN v_depment;
END $$
DELIMITER $$ ;
SELECT fn_them_depart ('Phòng chờ');

DROP PROCEDURE IF EXISTS update_and_delete_account_of_dep_2;
DELIMITER $$
CREATE PROCEDURE update_and_delete_account_of_dep_2
(IN in_departname_name_ VARCHAR(50) )
BEGIN
		UPDATE `account`
		SET department_id =  fn_them_depart ('Phòng chờ')
		WHERE department_id = fn_them_depart (in_departname_name_); -- giá trị nhập vào của procedure
        
		DELETE FROM department
        WHERE department_name LIKE CONCAT('%',in_departname_name_,'%');
END $$
DELIMITER $$ ;
CALL update_and_delete_account_of_dep_2 ('A1');

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")

