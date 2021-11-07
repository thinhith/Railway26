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