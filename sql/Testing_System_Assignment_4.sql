USE testing_system2;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ 
-- output account_id, fullname, department_id department_name
SELECT ac.account_id, ac.fullname,  d.department_id, d.department_name
FROM `account` ac
RIGHT JOIN department d ON ac.department_id = d.department_id;


-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
SELECT account_id, email, username, fullname, d.department_name, position_id, create_date
FROM `account` a -- CÁI NÀY MẶC ĐỊNH Ở BÊN TRÁI
INNER JOIN department d ON a.department_id = d.department_id
WHERE create_date <= '2021/10/25';



-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT ac.account_id, ac.username, ac.fullname, p.position_id, p.position_name
FROM `account` ac
INNER JOIN `position` p ON ac.position_id = p.position_id
WHERE p.position_id = '1';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
-- B1: Xác định output department, count(account)
-- b2; xác định loại join inner join

SELECT d.department_id, d.department_name, COUNT(ac.account_id) acc
FROM department d
INNER JOIN `account` ac ON d.department_id =  ac.department_id
GROUP BY d.department_id
HAVING COUNT(ac.account_id) >3;

-- Question 5: Viết lệnh để lấy ra danh sách câu  hỏi được sử dụng trong nhiều đề thi nhất 
-- B1: xác định output question_id content		count(exam_id)
SELECT q.questionid, q.content, COUNT(eq.exam_id)
FROM question q
LEFT JOIN examquestion eq ON q.questionid = eq.question_id
GROUP BY q.questionid
HAVING COUNT(eq.exam_id) = (SELECT max(number_of_exam) FROM (SELECT (COUNT(exam_id)) AS number_of_exam
															FROM examquestion
															GROUP BY question_id) AS temp); 

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question 
-- xác định output       categoryquestion  count(question id)
SELECT ca.category_id, ca.category_name, count(q.questionid) as "số lượng câu hỏi"
FROM categoryquestion ca
LEFT JOIN question q ON ca.category_id = q.category_id
GROUP BY ca.category_id, ca.category_name;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Ex am
-- xác định output
SELECT q.questionid, count(exd.exam_id)
FROM question q
INNER JOIN examquestion exd ON q.questionid = exd.question_id
GROUP BY  q.questionid
HAVING count(exd.exam_id) ;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
-- xác định output 		question				count(aw.answer)
SELECT q.questionid, count(aw.answer_id)
FROM question q
INNER JOIN answer aw ON q.questionid = aw.questionid
GROUP BY q.questionid
HAVING count(aw.answer_id) = (SELECT max(number_of_anwser) FROM (SELECT (count(answer_id)) AS number_of_anwser
																FROM answer 
																GROUP BY questionid ) AS temp) ;


-- Question 9: Thống kê số lượng account trong mỗi group

-- B1: xác định output group ID group name count(account_id)


SELECT ga.group_id, g.group_name ,  count(ga.account_id) AS " Số lượng account"
FROM groupaccount ga
LEFT JOIN `group` g ON	ga.group_id = g.group_id
LEFT JOIN `account` a ON ga.account_id = a.account_id
GROUP BY ga.group_id
HAVING count(ga.account_id);


-- Question 10: Tìm chức vụ có ít người nhất
-- p.position ID.    P.possion_name count(a.account)
SELECT p.position_id, p.position_name, count(a.account_id) AS "số nhân viên ít nhất"
FROM `position`p 
JOIN `account` a ON p.position_id = a.position_id
group by a.position_id
HAving count(a.account_id) = (SELECT min(number_of_acc) FROM (SELECT p.position_id, a.account_id,  count(a.account_id) AS number_of_acc
															FROM `account`a
																JOIN `position` p ON a.position_id = p.position_id
																	GROUP BY a.account_id
																		Having min(a.account_id) )AS temp);


-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM 
-- output deparrmentname(d)	positionname(p) count(account_id)(a)
SELECT d.department_name, p.position_name, count(a.account_id)
FROM department d
LEFT JOIN `account` a ON d.department_id = a.department_id
RIGHT JOIN `position`p ON a.position_id = p.position_id
GROUP BY d.department_id,p.position_id 
ORDER BY d.department_name;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- output ques_id.(q)   content (q)	 category_name(CQ)	type name(tq)	user name(a) fullname(a)	content(an)
SELECT q.questionid, q.content, cq.category_name,tq.type_id, tq.type_name, a.username , a.fullname, an.content
FROM question q
RIGHT JOIN  categoryquestion cq ON q.category_id = cq.category_id -- phải tạo chủ đề trước
RIGHT JOIN typequestion tq ON q.type_id = tq.type_id
LEFT JOIN `account` a ON q.creator_id = a.account_id
LEFT JOIN answer an ON q.questionid = an.questionid;

-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
 
-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm 
-- output  type_id(TQ), type_name(tq)  count(question_id)
SELECT tq.type_id, tq.type_name, count(q.questionid)
FROM typequestion tq 
INNER JOIN question q ON tq.type_id = q.type_id
GROUP BY q.type_id;

SELECT tq.type_id, tq.type_name, count(q.questionid)
FROM typequestion tq 
INNER JOIN question q ON tq.type_id = q.type_id
GROUP BY q.type_id;

-- Question 14:Lấy ra group không có account nào
-- output: group name group id account id count(accountid)
SELECT g.group_id, g.group_name, count(ga.account_id)
from `group` g
LEFT JOIN groupaccount ga on g.group_id = ga.group_id
GROUP BY g.group_id
HAVING count(ga.account_id) = 0;

-- c2
SELECT g.group_id, g.group_name, ga.account_id
from `group` g
LEFT JOIN groupaccount ga on g.group_id = ga.group_id
WHERE ga.account_id IS NULL;
-- output group_id group name

-- Question 16: Lấy ra question không có answer nào
-- output questionid(q)	questionname   count(answer)
SELECT q.questionid , q.content , count(an.answer_id)
FROM question q
RIGHT JOIN answer an ON q.questionid = an.questionid
GROUP BY an.questionid
HAVING count(an.answer_id) = 0;

-- Cách 2:

SELECT q.questionid , q.content , an.answer_id
FROM question q
RIGHT JOIN answer an ON q.questionid = an.questionid
WHERE an.answer_id IS NULL;

-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau

SELECT ga.group_id,g.group_name, count(a.account_id)
FROM groupaccount ga
LEFT JOIN `account` a ON ga.account_id = a.account_id
LEFT JOIN `group` g ON ga.group_id = g.group_id
GROUP BY ga.group_id
HAVING ga.group_id =1
UNION
SELECT ga.group_id,g.group_name, count(a.account_id)
FROM groupaccount ga
LEFT JOIN `account` a ON ga.account_id = a.account_id
LEFT JOIN `group` g ON ga.group_id = g.group_id
GROUP BY ga.group_id
HAVING ga.group_id =2;
-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b)

SELECT ga.group_id,g.group_name, count(a.account_id)
FROM groupaccount ga
LEFT JOIN `account` a ON ga.account_id = a.account_id
LEFT JOIN `group` g ON ga.group_id = g.group_id
GROUP BY ga.group_id
HAVING count(a.account_id)>=3
UNION
SELECT ga.group_id,g.group_name, count(a.account_id)
FROM groupaccount ga
LEFT JOIN `account` a ON ga.account_id = a.account_id
LEFT JOIN `group` g ON ga.group_id = g.group_id
GROUP BY ga.group_id
HAVING count(a.account_id)<7;

SELECT group_id, count(account_id)
FROM groupaccount
GROUP BY group_id
HAVING count(account_id);

-- lấy ra danh sách nhân viên thuộc phòng ban D1_
-- lệnh dùng join
SELECT a.*, d.department_name
FROM `account` a
INNER JOIN department d ON a.department_id = d.department_id
WHERE department_name = "A1";

-- lệnh subquery

SELECT *
FROM `account` 
WHERE department_id = (SELECT department_id FROM department WHERE department_name = "A1" );

SELECT question_id, COUNT(exam_id) AS number_of_exams
	FROM examquestion
    GROUP BY question_id;
    