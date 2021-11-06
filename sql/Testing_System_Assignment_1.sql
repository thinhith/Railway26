DROP DATABASE IF EXISTS testing_system2; -- xoá khởi tạo database
CREATE DATABASE testing_system2; -- Khởi tạo database
USE testing_system2; -- chỉ định database
-- Tạo bảng
CREATE TABLE department(
	department_id		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    department_name		VARCHAR(50) NOT NULL UNIQUE KEY CHECK (length(department_name)>1)
);
CREATE TABLE position (
	position_id			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    position_name		VARCHAR(30) NOT NULL UNIQUE KEY CHECK (length(position_name)>=1)
);
CREATE TABLE `account`(
	account_id			SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    email				VARCHAR(50) NOT NULL  CHECK (length(email)>=1),
    username			VARCHAR(50) NOT NULL  CHECK (length(username)>=1),
    fullname			VARCHAR(100) NOT NULL  CHECK (length(fullname)>=1),
    department_id		TINYINT UNSIGNED NOT NULL,
    position_id			TINYINT UNSIGNED,
    create_date			DATETIME DEFAULT NOW(),
-- Có để trung gian khoá chính được ko
    FOREIGN KEY (department_id) REFERENCES department (department_id),
    FOREIGN KEY (position_id)	REFERENCES `position` (position_id)
);
CREATE TABLE `group`(
	group_id			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    group_name			VARCHAR(50) UNIQUE NOT NULL,
    creator_id			SMALLINT UNSIGNED NOT NULL,
    create_date			DATETIME DEFAULT NOW(),
    FOREIGN KEY (creator_id) REFERENCES `account` (account_id) ON DELETE CASCADE
    
);
CREATE TABLE groupaccount(
	group_id			TINYINT UNSIGNED NOT NULL,
    account_id			SMALLINT	UNSIGNED NOT NULL,
    join_date			DATETIME DEFAULT NOW(),
    PRIMARY KEY (group_id, account_id),
    FOREIGN KEY (group_id) REFERENCES `group` (group_id) ON DELETE CASCADE,
    FOREIGN KEY (account_id) REFERENCES `account` (account_id) ON DELETE CASCADE
);
CREATE TABLE typequestion (
	type_id				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    type_name			ENUM ('easay','multiple-choice)') NOT NULL 
);
CREATE TABLE categoryquestion (
	category_id			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    category_name		VARCHAR(50) NOT NULL
);
CREATE TABLE question (
	questionid			SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    content				VARCHAR(500) UNIQUE NOT NULL CHECK (length(content)>1),
    category_id			TINYINT UNSIGNED  NOT NULL,
    type_id				TINYINT UNSIGNED  NOT NULL,
    creator_id			SMALLINT UNSIGNED NOT NULL,
    createdate			DATETIME DEFAULT NOW(),
    FOREIGN KEY (creator_id) REFERENCES `account` (account_id)ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categoryquestion (category_id)ON DELETE CASCADE,
    FOREIGN KEY (type_id) REFERENCES typequestion (type_id)ON DELETE CASCADE
);
CREATE TABLE answer (
	answer_id			SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT, -- thay bằng SMALLINT--
    content				VARCHAR(200) UNIQUE NULL CHECK (length(content)>1),
    questionid			SMALLINT UNSIGNED NOT NULL,  -- THAY BẰNG SMALL--
    iscorrect			ENUM ('True','False') NOT NULL,
    FOREIGN KEY (questionid) REFERENCES question (questionid)ON DELETE CASCADE
);
CREATE TABLE exam (
	exam_id				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `code`				VARCHAR(20) UNIQUE NOT NULL,
    tittle				VARCHAR(50) UNIQUE NOT NULL CHECK (length(tittle)>2),
    category_id			TINYINT UNSIGNED NOT NULL,
    creator_id			SMALLINT UNSIGNED NOT NULL,
    duration			TINYINT UNSIGNED NOT NULL CHECK ( duration >= 15 AND duration <= 160 ),
    createdate			DATETIME DEFAULT NOW(),
    FOREIGN KEY (category_id) REFERENCES categoryquestion (category_id)ON DELETE CASCADE,
    FOREIGN KEY (creator_id) REFERENCES `account` (account_id) ON DELETE CASCADE
);
CREATE TABLE examquestion (
	exam_id				TINYINT UNSIGNED NOT NULL ,
    question_id			SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (exam_id	,question_id	),
    FOREIGN KEY (question_id) REFERENCES question (questionid) ON DELETE CASCADE,
    FOREIGN KEY (exam_id) REFERENCES exam (exam_id)ON DELETE CASCADE