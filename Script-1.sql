USE ASSIGNMENT;
CREATE TABLE department(
departmentID int AUTO_INCREMENT,
departmentName varchar(50),
CONSTRAINT department_pk PRIMARY KEY (departmentID)
);

CREATE TABLE positions(
positionID int AUTO_INCREMENT ,
positionName varchar(50) ,
CONSTRAINT position_pk PRIMARY KEY (positionID)
);

CREATE TABLE account(
accountID int AUTO_INCREMENT,
email varchar(50),
userName varchar(50),
fullName varchar(50),
departmentID int,
positionID int,
createDate date,
CONSTRAINT account_pk PRIMARY KEY (accountID),
CONSTRAINT fk_htk_department FOREIGN KEY (departmentID)
REFERENCES department(departmentID),
CONSTRAINT fk_htk_positions FOREIGN KEY (positionID)
REFERENCES positions(positionID)
);

ALTER TABLE account
RENAME INDEX fk_htk_department TO fk_account_department;

ALTER TABLE account
RENAME INDEX fk_htk_positions TO fk_account_positions;


CREATE TABLE group_s(
groupID int AUTO_INCREMENT ,
groupName varchar(50),
createID int,
createData date,
CONSTRAINT group_s_pk PRIMARY KEY (groupID)
);

CREATE TABLE groupAccount(
groupID int,
accountID int,
joinDate date
);

ALTER TABLE groupAccount 
ADD CONSTRAINT fk_grA_gr
FOREIGN KEY (groupID)
REFERENCES group_s(groupID);

ALTER TABLE groupAccount 
ADD CONSTRAINT fk_AgrA_ac
FOREIGN KEY (accountID)
REFERENCES account(accountID);

CREATE TABLE typeQuestion(
typeID int AUTO_INCREMENT ,
typeName varchar(50),
CONSTRAINT typeQuestion_pk PRIMARY KEY (typeID)
);

CREATE TABLE categoryQuestion(
categoryID int AUTO_INCREMENT,
categoryName varchar(50),
CONSTRAINT categoryQuestion_pk PRIMARY KEY (categoryID)
);

CREATE TABLE question(
questionID int AUTO_INCREMENT,
content varchar(2000),
categoryID int,
typeID int,
creatorID int,
createDate date,
CONSTRAINT question_pk PRIMARY KEY (questionID),
CONSTRAINT fk_question_category FOREIGN KEY (categoryID)
REFERENCES categoryQuestion (categoryID),
CONSTRAINT fk_question_type FOREIGN KEY (typeID)
REFERENCES typeQuestion (typeID)
);

CREATE TABLE answer (
answerID int AUTO_INCREMENT,
content varchar(2000),
questionID int,
isCorrect boolean,
CONSTRAINT answer_pk PRIMARY KEY (answerID),
CONSTRAINT fk_answer_question FOREIGN KEY (questionID)
REFERENCES question(questionID)
);

CREATE TABLE exam(
examID int AUTO_INCREMENT,
code varchar(20),
title varchar(50),
categoryID int,
duration date,
creatorID int,
createDate date,
CONSTRAINT exam_pk PRIMARY KEY (examID),
CONSTRAINT fk_exam_category FOREIGN KEY (categoryID)
REFERENCES categoryQuestion (categoryID)
);

CREATE TABLE examQuestion(
examID int,
questionID int,
CONSTRAINT fk_examQ_exam FOREIGN KEY (examID)
REFERENCES exam(examID),
CONSTRAINT fk_examQ_question FOREIGN KEY (questionID)
REFERENCES question(questionID)
);

/* Add table */

INSERT INTO account
(email, userName, fullName, departmentID, positionID, createDate)
VALUES ('hoannnt2107@gmail.com', 'hoannnt21', 'Nguyen Ngoc Tran Hoan', 1,3,
'2021-06-26');

INSERT INTO groupaccount 
(groupID, accountID,joinDate)
VALUES
(1 , 1 , '2021-06-26');

INSERT INTO typeQuestion
(typeName)
VALUES ('Multiple-Choise');

INSERT INTO categoryquestion 
(categoryName)
VALUES
('Ruby');

INSERT INTO question
(content, categoryID, typeID,creatorID, createDate)
VALUES
('Add at least 10 records to each table', 1,1,1,'2021-08-26');

INSERT INTO answer 
(content, questionID, isCorrect)
VALUES
('INSERT INTO question
(content, categoryID, typeID,creatorID, createDate)
VALUES (Add at least 10 records to each table, 1,1,1,2021-08-26);',1 ,1);

INSERT INTO exam 
(code, title, categoryID, duration, creatorID, createDate)
VALUES
('A-101', 'Excute SQL', 3, '2021-08-28', 1, '2021-08-20');

INSERT INTO examquestion
(examID, questionID)
VALUES
(1,1);

INSERT INTO department 
(departmentName)
VALUES
('HR');

/* Question 2 */

SELECT * FROM department ;

/* Question3  */
SELECT departmentID
FROM department
WHERE departmentName LIKE '%Sale%';

/* Question 4 */
SELECT * FROM account
ORDER BY fullName ASC;

SELECT MAX(fullName)
FROM account;

/* Question 5 */
SELECT * FROM account
WHERE departmentID =3
ORDER BY fullName ASC;

/* Question 6 */
SELECT groupName 
FROM group_s
WHERE createData < CAST('2019-12-20' AS DATE);

/* Question7 */

SELECT questionID , count(*)
FROM answer 
GROUP BY questionID 
HAVING count(*) >=4
ORDER BY count(*) DESC;

SELECT count(*)
FROM answer
GROUP BY questionID;

SELECT questionID
FROM answer
GROUP BY questionID
ORDER BY count(*) DESC
LIMIT 1;

/* Question 8 */
/* Sai kiểu dữ liệu */

/* Question 9 */

SELECT date(now()) today;

SELECT current_date() today; 

SELECT *
FROM group_s
ORDER BY createData DESC
LIMIT 5;

/* Question 10 */

SELECT count(*)
FROM account
WHERE departmentID =2;

/* Question 11*/
SELECT *
FROM account
WHERE fullName LIKE 'D%o';

/* Question 12 */

DELETE 
FROM exam 
WHERE createDate < CAST('2019-12-20' AS DATE);

/* Question 13 */

DELETE FROM question
WHERE content LIKE 'Câu hỏi%';

/* Question 14 */
 UPDATE account 
 SET fullName = 'Nguyễn Bá Lộc',
 email ='loc.nguyenba@vti.com.vn'
WHERE accountID =5;
/* Question 15 */

 UPDATE groupaccount 
 SET groupID = 4
WHERE accountID =5;

/****   SQL – Assignment 4 ******/

/* Question 1 */

SELECT account.*, department.departmentName 
FROM account
INNER JOIN department
WHERE account.departmentID = department.departmentID;

/*  Question 2 */

SELECT a.*
FROM account a
WHERE a.createDate > '2020-12-02';

/* Question 3 */


SELECT * 
FROM account
WHERE positionID = 1;

/* Question 4 */
/* Truy Vấn con trong From và Select ? */

SELECT departmentID 
FROM account 
GROUP BY departmentID 
HAVING count(*) >3;

SELECT *
FROM department
WHERE departmentID IN (
SELECT departmentID 
FROM account 
GROUP BY departmentID 
HAVING count(*) >3
);

/* Question 5 */

SELECT *
FROM question
WHERE questionID IN (
SELECT questionID 
FROM examquestion
GROUP BY questionID
ORDER BY count(*) DESC
);

SELECT questionID 
FROM examquestion
GROUP BY questionID 
ORDER BY count(*) DESC;

SELECT question.*
FROM question
INNER JOIN examquestion
WHERE question.questionID = examquestion.questionID 
GROUP BY examquestion.questionID 
ORDER BY count(*) DESC;

/* 
 * SELECT question.*
FROM question
INNER JOIN examquestion
WHERE question.questionID = examquestion.questionID 
GROUP BY examquestion.questionID 
ORDER BY examquestion.count(*) DESC;
 * ?????????????? */

/* Question 6 */

SELECT categoryquestion.*, count(*)
FROM categoryquestion
INNER JOIN question
ON categoryquestion.categoryID  = question.categoryID 
GROUP BY question.categoryID 
ORDER BY count(*) DESC ;



/* Question 7 */

SELECT questionID , count(*) AS 'So lan su dung'
FROM examquestion 
GROUP BY questionID 
ORDER BY count(*) DESC;

/* Question 8 */

SELECT *
FROM question
WHERE questionID IN (
SELECT questionID 
FROM answer
GROUP BY questionID 
ORDER BY count(*) DESC);


SELECT questionID 
FROM answer
GROUP BY questionID 
ORDER BY count(*) DESC 
LIMIT 1 ;

SELECT *
FROM question q 
INNER JOIN answer a
ON q.questionID = a.questionID 
GROUP BY a.questionID 
ORDER BY count(*) DESC 
LIMIT 1 ;

/* Question 9 */

SELECT groupID , count(*) AS 'So Account' 
FROM groupaccount g 
GROUP BY groupID 
ORDER BY count(*) DESC;

/*  Question 10  */

SELECT p.positionName 
FROM positions p 
INNER JOIN account a 
WHERE p.positionID = a.positionID 
GROUP BY a.positionID 
ORDER BY count(*) ASC
LIMIT 1;

/* Question 11 */

SELECT d.*, count(*) AS 'DEV'
FROM department d 
INNER JOIN account a 
WHERE d.departmentID = a.departmentID AND a.positionID =3
GROUP BY a.departmentID 
ORDER BY count(a.positionID) DESC ;

/* Thay đổi a.positionID = ? để tìm chức vụ khác */

SELECT a.departmentID ,count(*) AS 'DEV'
FROM account a 
WHERE positionID = 3;

/* Question 12 */

SELECT q.questionID , q.content, c.categoryName , t.typeName ,a.content 
FROM question q 
LEFT JOIN answer a   
ON q.questionID = a.questionID
LEFT JOIN categoryquestion c
ON q.categoryID = c.categoryID
LEFT JOIN typequestion t
ON q.typeID = t.typeID 
GROUP BY q.questionID ;

SELECT q.questionID , q.content , a.content 
FROM question q 
LEFT JOIN answer a 
ON q.questionID = a.questionID 
GROUP BY q.questionID ; /* Test */


SELECT c.categoryName 
FROM categoryquestion c 
RIGHT JOIN question q 
ON q.categoryID = c.categoryID ; /* Test */

/* Question 13 */

SELECT t.*, count(*) AS 'So luong question' 
FROM question q 
INNER JOIN typequestion t 
WHERE q.typeID = t.typeID 
GROUP BY q.typeID 
ORDER BY count(*) DESC;

SELECT q.typeID , count(*)
FROM question q 
GROUP BY typeID 
ORDER BY count(*);

/* Question 14 */

SELECT * 
FROM group_s gs 
WHERE NOT EXISTS (
SELECT *
FROM groupaccount g 
WHERE g.groupID = gs.groupID );

/*  Question 15 ????? Giống 14 ? */

/* Question 16 */

SELECT *
FROM question q 
WHERE NOT EXISTS (
SELECT *
FROM answer a 
WHERE a.questionID = q.questionID 
);

/* Question 17 */

SELECT a.*
FROM account a 
INNER JOIN groupaccount g 
WHERE a.accountID = g.accountID AND g.groupID = 1;

SELECT a.*
FROM account a 
INNER JOIN groupaccount g 
WHERE a.accountID = g.accountID AND g.groupID = 2;

SELECT a.*
FROM account a 
INNER JOIN groupaccount g 
WHERE a.accountID = g.accountID AND g.groupID = 1
UNION
SELECT a.*
FROM account a 
INNER JOIN groupaccount g 
WHERE a.accountID = g.accountID AND g.groupID = 2;


/* Question 18 */

SELECT gs.*
FROM group_s gs 
INNER JOIN groupaccount g 
WHERE gs.groupID = g.groupID
GROUP BY g.groupID 
HAVING count(gs.groupID) > 5;

SELECT gs.*
FROM group_s gs 
INNER JOIN groupaccount g 
WHERE gs.groupID = g.groupID
GROUP BY g.groupID 
HAVING count(gs.groupID) <7;

SELECT gs.*
FROM group_s gs 
INNER JOIN groupaccount g 
WHERE gs.groupID = g.groupID
GROUP BY g.groupID 
HAVING count(gs.groupID) > 5
UNION 
SELECT gs.*
FROM group_s gs 
INNER JOIN groupaccount g 
WHERE gs.groupID = g.groupID
GROUP BY g.groupID 
HAVING count(gs.groupID) <7;

/* Assignment 5 */

/* Question 1 */

SELECT a.*
FROM account a 
WHERE departmentID =11;

CREATE VIEW list_sale AS
SELECT a.*
FROM account a 
WHERE departmentID =11;

/* Question 2 */


SELECT a.*
FROM account a 
INNER JOIN groupaccount g 
WHERE a.accountID = g.accountID 
GROUP BY g.accountID 
ORDER BY count(g.accountID) DESC;

CREATE VIEW list_GrAccount AS
SELECT a.*
FROM account a 
INNER JOIN groupaccount g 
WHERE a.accountID = g.accountID 
GROUP BY g.accountID 
ORDER BY count(g.accountID) DESC;

/* Question 3 */

SELECT *, LENGTH(content) AS 'Do dai Content'
FROM question q 
WHERE LENGTH(content) >= 40;

SELECT *, LENGTH(content) AS 'Do dai Content'
FROM question q 
HAVING LENGTH(content) >= 40
ORDER BY LENGTH(content) DESC;

SELECT length(content)
FROM question q ;

CREATE VIEW list_Quest AS 
SELECT *, LENGTH(content) AS 'Do dai Content'
FROM question q 
HAVING LENGTH(content) >= 40
ORDER BY LENGTH(content) DESC;

/* Question 4 */

SELECT d.departmentName, count(a.departmentID) AS 'So nhan vien'
FROM department d 
INNER JOIN account a 
WHERE d.departmentID = a.departmentID 
GROUP BY a.departmentID 
ORDER BY count(a.departmentID) DESC; 

CREATE VIEW list_department AS
SELECT d.departmentName, count(a.departmentID) AS 'So nhan vien'
FROM department d 
INNER JOIN account a 
WHERE d.departmentID = a.departmentID 
GROUP BY a.departmentID 
ORDER BY count(a.departmentID) DESC; 

/* Question 5 */

/* Chưa nối khóa */

/*  Assignment 6 */

/* Question 1 */

SELECT a.*
FROM account a 
INNER JOIN department d 
ON a.departmentID = d.departmentID 
WHERE d.departmentName LIKE '%Sale%';

SELECT a.fullName 
FROM account a ;



CREATE PROCEDURE acc_department (IN dpm_Name varchar)
BEGIN 
	SELECT a.*
FROM account a 
INNER JOIN department d 
ON a.departmentID = d.departmentID 
WHERE d.departmentName LIKE dpm_Name 
END;

DELIMITER //
CREATE PROCEDURE test_1()
BEGIN
	SELECT * FROM account ;
END //
DELIMITER ;

CALL test_1();

SELECT a;

/* Assignment 7 */

/* Question1 */
CREATE TRIGGER question1
BEFORE INSERT 
ON groupaccount FOR EACH ROW 
BEGIN 
	
END













