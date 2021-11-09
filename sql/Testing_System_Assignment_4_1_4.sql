USE testing_system2;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ 
-- output account_id, fullname, department_id department_name
SELECT ac.account_id, ac.fullname,  d.department_id, d.department_name
FROM `account` ac
RIGHT JOIN department d ON ac.department_id = d.department_id;


-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
SELECT account_id, email, username, fullname, d.department_name, position_id, create_date
FROM `account` a
INNER JOIN department d ON a.department_id = d.department_id
WHERE create_date <= '2021/10/25';



-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT ac.account_id, ac.username, ac.fullname, p.position_id, p.position_name
FROM `account` ac
INNER JOIN `position` p ON ac.position_id = p.position_id
WHERE p.position_name = 'Dev';