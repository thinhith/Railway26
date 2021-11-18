USE testing_system2;
-- Question 1: Tạo view có chứa  danh sách nhân viên thuộc phòng ban A1
-- B1: xác định output 
-- cách 1
SELECT d.department_id, d.department_name, COUNT(a.account_id)
FROM department d
JOIN `account`a ON d.department_id = a.department_id
GROUP BY d.department_id
HAVING COUNT(a.account_id) =  (SELECT department_id, department_name
								FROM department
									WHERE department_name = 'A1'  )
                                            
	;
-- cách 2
DROP VIEW IF EXISTS list_deparment_A1;
CREATE VIEW list_deparment_A1 AS SELECT a.account_id, a.email, a.username, a.fullname, d.department_id, d.department_name
FROM `account` a
JOIN department d ON a.department_id = d.department_id
WHERE d.department_name = 'A1' ;

 SELECT * FROM list_deparment_a1;

SELECT a.account_id, a.email, a.username, a.fullname, d.department_id, d.department_name
FROM `account` a
JOIN department d ON a.department_id = d.department_id
WHERE d.department_name = 'A1' ;
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất 
-- xác định output account_id, group, groupaccount



DROP VIEW IF EXISTS user_take_park_in_the_most_group;
CREATE VIEW user_take_park_in_the_most_group AS
SELECT a.account_id, a.fullname,a.email, a.username, count(ga.account_id) "Số group tham gia", GROUP_CONCAT(group_name)
FROM `account` a
LEFT JOIN groupaccount ga ON a.account_id = ga.account_id 
LEFT JOIN `group` g ON g.group_id = ga.group_id
GROUP BY a.account_id
HAVING count(ga.account_id) = (SELECT max(acc_id) FROM 
								(SELECT a.account_id ,(count(ga.group_id)) AS acc_id
									FROM	`account` a
										JOIN groupaccount ga ON ga.account_id = a.account_id
											GROUP BY a.account_id
												HAVING count(ga.group_id)) AS temp);


SELECT * FROM user_take_park_in_the_most_group;


SELECT a.account_id, a.fullname,a.email, a.username, count(ga.group_id) "Số group tham gia", GROUP_CONCAT(group_name)
FROM `account` a
INNER JOIN groupaccount ga ON a.account_id = ga.account_id 
INNER JOIN `group` g ON g.group_id = ga.group_id
GROUP BY a.account_id
HAVING count(ga.group_id) = (SELECT MAX(num) FROM (SELECT (count(group_id)) AS num
														FROM groupaccount
															GROUP BY account_id) AS temp)
ORDER BY count(ga.group_id) DESC
LIMIT 2;
   

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ  được coi là quá dài) và xóa nó đi

DROP VIEW IF EXISTS content_too_long;
CREATE VIEW content_too_long AS 
SELECT *
FROM question
WHERE length(content) > 50;

SELECT * FROM content_too_long;

DELETE 
FROM content_too_long;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất 
-- cách 1
SELECT d.department_id, d.department_name, count(a.account_id) AS number
FROM `account` a 
JOIN department d ON a.department_id = d.department_id
GROUP BY a.department_id
ORDER BY count(a.account_id) DESC
LIMIT 1;

-- cách 2
DROP VIEW IF EXISTS menber_in_dep;
CREATE VIEW menber_in_dep AS
SELECT d.department_id, d.department_name, count(a.account_id) AS number
FROM `account` a 
JOIN department d ON a.department_id = d.department_id
GROUP BY a.department_id
HAVING count(a.account_id) = (SELECT max(max_d) FROM (SELECT (count(account_id)) AS max_d
									FROM `account`
										GROUP BY department_id) AS high);
SELECT * FROM menber_in_dep;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
-- c1
DROP VIEW IF EXISTS v_question;
CREATE VIEW v_question AS
SELECT *
FROM question 
WHERE creator_id = ANY (SELECT account_id  -- câu này cũng có thể dùng IN
						FROM `account`
							WHERE fullname LIKE 'Nguyễn%');
SELECT * FROM v_question;

-- C2
                        
DROP VIEW IF EXISTS ques_of_nguyen;
CREATE VIEW ques_of_nguyen AS
SELECT questionid, content, category_id, type_id, creator_id, createdate, a.fullname
FROM question q
INNER JOIN `account`a ON a.account_id = q.creator_id
WHERE a.fullname LIKE 'Nguyễn%';

SELECT * FROM ques_of_nguyen;