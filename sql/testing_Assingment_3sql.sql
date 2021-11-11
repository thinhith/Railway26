USE testing_system2;
-- Question 2: lấy ra tất cả các phòng ban
SELECT *
FROM department;

-- Question 3: lấy ra id của phòng ban "A1"

SELECT department_id, department_name
FROM department
WHERE department_name = 'A1';

-- Question 4: lấy ra thông tin account có full name dài nhất
-- cách 1:
SELECT  DISTINCT fullname , length(fullname)
FROM `account`
GROUP BY fullname
HAVING length(fullname) = max(length(fullname)) 
ORDER BY length(fullname) DESC
LIMIT 1;
-- Cách 2:

SELECT *
FROM `account`
 WHERE length(fullname) = (SELECT max(length(fullname)) FROM `account` )
ORDER BY fullname ASC;



-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id=3
-- cách 1: 
SELECT account_id,username,position_id,create_date,fullname, length(fullname) AS "tên dài nhất"
FROM `account`
WHERE department_id = 3
GROUP BY account_id
ORDER BY length(fullname) DESC
LIMIT 1;

-- Cách 2

SELECT account_id,username,position_id,create_date,fullname, length(fullname) AS "tên dài nhất"
FROM `account`
WHERE department_id = 3 AND length(fullname) = (SELECT max(length(fullname)) FROM `account` WHERE department_id = 3 );

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019

SELECT group_name
FROM `group`
WHERE create_date <"2021/10/22";

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời

SELECT DISTINCT questionid, count(answer_id)
FROM answer
GROUP BY questionid
HAVING count(questionid) >=4;



-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019

SELECT `code`, duration, createdate
FROM exam
WHERE duration >=60 AND createdate < "2021/10/22" ;


-- Question 9: Lấy ra 5 group được tạo gần đây nhất

SELECT *
FROM `group`
WHERE create_date 
LIMIT 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2

SELECT department_id,COUNT(account_id) AS "Tổng số nhân viên"
FROM `account`
WHERE department_id = 5;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"

SELECT *
FROM `account`
WHERE fullname LIKE "N%h";

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019

DELETE FROM examquestion
WHERE exam_id  IN (SELECT exam_id FROM exam WHERE createdate <'2021-10-20' );

DELETE FROM exam
WHERE createdate <'2021-10-20 23:58:33';


-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE FROM question
WHERE content like 'SQL%';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn


UPDATE `account`
SET fullname = "Nguyễn Bá Lộc", email = "loc.nguyenba@vti.com.vn"
WHERE department_id = 1;
 
-- cách 1 - sa thải toàn bộ nhân viên thuộc phòng ban A1
DELETE FROM `account`
WHERE department_id = 1;
DELETE FROM department
WHERE department_id =1;
-- trong lệnh delete này cần có sự liên kết của các khoá nên sẽ có cách làm khác.

-- Cách 2 chuyển các nhân viên từ A1 sang A2

UPDATE `account`
SET department_id = 2
WHERE department_id = 1 AND account_id IN (1,9);

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4

UPDATE groupaccount
SET group_id = 1
WHERE	account_id  IN (SELECT fullname FROM `account` WHERE fullname = 6);

SELECT fullname FROM `account` WHERE account_id = 5;

UPDATE exam
SET duration = '90'
WHERE exam_id = 2;








