USE fresher_example


CREATE TABLE trainee(
traineeID int PRIMARY KEY AUTO_INCREMENT ,
fullNamme varchar(100),
birthDate Date,
gender varchar(10) NOT NULL CHECK (gender IN ('Male','Female', 'Unknown')),
ET_IQ int NOT NULL CHECK (ET_IQ BETWEEN 0 AND 20),
ET_Gmath int NOT NULL CHECK (ET_Gmath BETWEEN 0 AND 20),
ET_English int NOT NULL CHECK (ET_English BETWEEN 0 AND 50),
tranningClass varchar(20),
evaluation_Notes varchar(300) 
);

ALTER TABLE trainee 
ADD VTI_Account varchar(50) NOT NULL UNIQUE;


CREATE TABLE exercise2 (
ID int PRIMARY KEY AUTO_INCREMENT,
name varchar(100),
code char(5),
modififiedDate timestamp
);

CREATE TABLE dataType2( 
ID int PRIMARY KEY AUTO_INCREMENT,
name varchar(100),
birthDate date,
gender int ,
isDeletedFlag int
);


/*  Assignment3  */

/*v1v*/
INSERT INTO trainee 
(fullNamme,birthDate,gender,ET_IQ,ET_Gmath,ET_English
,tranningClass,evaluation_Notes,VTI_Account)
VALUES ('Nguyen Ngoc Tran Hoan', '1999-07-21'
, 'Male', 20,20,20, 'A102','Perfect', 'hoannnt2107@gmail.com');
/*v2v*/
INSERT INTO trainee 
(fullNamme,birthDate,gender,ET_IQ,ET_Gmath,ET_English
,tranningClass,evaluation_Notes,VTI_Account)
VALUES ('Pham Do Anh', '2000-08-21'
, 'Male', 12,12,12, 'A102','Normal', 'chongao@gmail.com');
/*v3v*/
INSERT INTO trainee 
(fullNamme,birthDate,gender,ET_IQ,ET_Gmath,ET_English
,tranningClass,evaluation_Notes,VTI_Account)
VALUES ('Ho THi Ngoc Anh', '2000-06-28'
, 'Female', 20,20,20, 'A102','Perfect', 'hinataho286@gmail.com');
/*v4v*/
INSERT INTO trainee 
(fullNamme,birthDate,gender,ET_IQ,ET_Gmath,ET_English
,tranningClass,evaluation_Notes,VTI_Account)
VALUES ('Le Cao Dinh', '1999-02-18'
, 'Male',2,2,2, 'A101','Normal', 'dinhlc@gmail.com');
/*v5v*/
INSERT INTO trainee 
(fullNamme,birthDate,gender,ET_IQ,ET_Gmath,ET_English
,tranningClass,evaluation_Notes,VTI_Account)
VALUES ('Do Xuan Hinh', '1999-10-14'
, 'Male', 20,20,20, 'A102','Perfect', 'hinhxuan104@gmail.com');
/*v6v*/
INSERT INTO trainee 
(fullNamme,birthDate,gender,ET_IQ,ET_Gmath,ET_English
,tranningClass,evaluation_Notes,VTI_Account)
VALUES ('Pham Van Kha', '1999-02-20'
, 'Male', 20,20,20, 'A102','Perfect', 'khatayphong@gmail.com');
/*v7v*/
INSERT INTO trainee 
(fullNamme,birthDate,gender,ET_IQ,ET_Gmath,ET_English
,tranningClass,evaluation_Notes,VTI_Account)
VALUES ('Pham Duy Dat', '1999-05-12'
, 'Male', 20,20,20, 'A102','Perfect', 'iamnang@gmail.com');
/*v8v*/
INSERT INTO trainee 
(fullNamme,birthDate,gender,ET_IQ,ET_Gmath,ET_English
,tranningClass,evaluation_Notes,VTI_Account)
VALUES ('Tran Le Nguyen', '1999-10-18'
, 'Male', 20,20,20, 'A101','Perfect', 'nguyen2k6@gmail.com');
/*v9v*/
INSERT INTO trainee 
(fullNamme,birthDate,gender,ET_IQ,ET_Gmath,ET_English
,tranningClass,evaluation_Notes,VTI_Account)
VALUES ('Nguyen Tran Anh Khoa', '1999-08-25'
, 'Male', 20,20,20, 'A101','Perfect', 'khoa2k6@gmail.com');
/*v10v*/
INSERT INTO trainee 
(fullNamme,birthDate,gender,ET_IQ,ET_Gmath,ET_English
,tranningClass,evaluation_Notes,VTI_Account)
VALUES ('Tran Gia Han', '1999-08-29'
, 'Female', 20,20,20, 'A101','Perfect', 'han2010@gmail.com');

/* Quest2 */

SELECT *
FROM trainee t
ORDER BY CAST(birthDate AS date ) desc ;

/* Quest 3 */

SELECT fullNamme ,max(LENGTH(fullNamme)) AS 'Do dai ten' 
FROM trainee t 
GROUP BY fullNamme 
ORDER BY LENGTH(fullNamme) desc;

SELECT fullNamme ,max(LENGTH(fullNamme)) AS 'Do dai ten' 
FROM trainee t ;

/* Quest 4 */

SELECT *
FROM trainee t 
WHERE ET_IQ + ET_Gmath >=20
AND ET_IQ >=8
AND ET_Gmath >=8
AND ET_English >=18;

DELETE FROM trainee
WHERE traineeID =9;

UPDATE trainee 
SET tranningClass = 'A101'
WHERE traineeID =5;


/*  Assignment 4  */


CREATE TABLE department(
department_Number int PRIMARY KEY AUTO_INCREMENT ,
department_Name varchar (50)
);

CREATE TABLE employee_table(
employee_Number int PRIMARY KEY AUTO_INCREMENT,
employee_Name varchar(100),
department_Number int,
CONSTRAINT fk_employee_department FOREIGN KEY (department_Number)
REFERENCES department(department_Number)
);

CREATE TABLE employss_skill_table(
employee_Number int,
skill_Code varchar(200),
date_Registered date,
CONSTRAINT fkk_skill_employee FOREIGN KEY (employee_Number)
REFERENCES employee_table(employee_Number)
);

/* Department */
INSERT INTO department 
(department_Name)
VALUES ('Sale');
INSERT INTO department 
(department_Name)
VALUES ('Marketing');
INSERT INTO department 
(department_Name)
VALUES ('HR');
INSERT INTO department 
(department_Name)
VALUES ('San Xuat');
INSERT INTO department 
(department_Name)
VALUES ('Nhan su');
INSERT INTO department 
(department_Name)
VALUES ('Ban quan tri');
INSERT INTO department 
(department_Name)
VALUES ('Phong hanh chinh');
INSERT INTO department 
(department_Name)
VALUES ('Ban quan ly');
INSERT INTO department 
(department_Name)
VALUES ('Ban kiem soat');
INSERT INTO department 
(department_Name)
VALUES ('Phong kinh doanh');

/* Employss */

INSERT INTO employee_table 
(employee_Name ,department_Number)
VALUES ('Nguyen Ngoc Tran Hoan', 1);
INSERT INTO employee_table 
(employee_Name ,department_Number)
VALUES ('Pham Do Anh', 1);
INSERT INTO employee_table 
(employee_Name ,department_Number)
VALUES ('Ho THi Ngoc Anh', 2);
INSERT INTO employee_table 
(employee_Name ,department_Number)
VALUES ('Le Cao Dinh', 2);
INSERT INTO employee_table 
(employee_Name ,department_Number)
VALUES ('Do Xuan Hinh', 3);
INSERT INTO employee_table 
(employee_Name ,department_Number)
VALUES ('Pham Van Kha', 3);
INSERT INTO employee_table 
(employee_Name ,department_Number)
VALUES ('Pham Duy Dat', 4);
INSERT INTO employee_table 
(employee_Name ,department_Number)
VALUES ('Tran Le Nguyen', 4);
INSERT INTO employee_table 
(employee_Name ,department_Number)
VALUES ('Nguyen Tran Anh Khoa', 5);
INSERT INTO employee_table 
(employee_Name ,department_Number)
VALUES ('Tran Gia Han', 5);

/* Employss skill */

INSERT INTO employss_skill_table 
(employee_Number, skill_Code, date_Registered)
VALUES (1,'Java,Php', '2020-06-06');
INSERT INTO employss_skill_table 
(employee_Number, skill_Code, date_Registered)
VALUES (2,'C#,Php', '2021-06-06');
INSERT INTO employss_skill_table 
(employee_Number, skill_Code, date_Registered)
VALUES (3,'Java,C++,C#', '2020-12-06');
INSERT INTO employss_skill_table 
(employee_Number, skill_Code, date_Registered)
VALUES (4,'Python,Ruby', '2020-06-06');
INSERT INTO employss_skill_table 
(employee_Number, skill_Code, date_Registered)
VALUES (5,'JavaScript,Php,Swift', '2020-06-06');
INSERT INTO employss_skill_table 
(employee_Number, skill_Code, date_Registered)
VALUES (6,'TypeScript', '2021-06-16');
INSERT INTO employss_skill_table 
(employee_Number, skill_Code, date_Registered)
VALUES (7,'Ruby', '2021-03-16');
INSERT INTO employss_skill_table 
(employee_Number, skill_Code, date_Registered)
VALUES (8,'Prel,Groovy', '2021-05-12');
INSERT INTO employss_skill_table 
(employee_Number, skill_Code, date_Registered)
VALUES (9,'Python,Php', '2021-08-12');
INSERT INTO employss_skill_table 
(employee_Number, skill_Code, date_Registered)
VALUES (10,'C#,C++,C', '2021-09-16');

/* Q3 */

SELECT et.employee_Name , est.skill_Code 
FROM employee_table et 
INNER JOIN employss_skill_table est 
WHERE et.employee_Number = est.employee_Number 
AND est.skill_Code LIKE '%Java%';

/* Q4 */

SELECT d.department_Name , count(et.department_Number) AS 'So luong NV' 
FROM department d 
INNER JOIN employee_table et 
WHERE d.department_Number = et.department_Number
GROUP BY et.department_Number 
HAVING count(*) > 3 
ORDER BY count(et.department_Number) DESC;

/* Q5 */




SELECT et.employee_Name , d.department_Name
FROM employee_table et 
INNER JOIN department d 
WHERE et.department_Number = d.department_Number 
AND et.department_Number =1
UNION 
SELECT et.employee_Name , d.department_Name
FROM employee_table et 
INNER JOIN department d 
WHERE et.department_Number = d.department_Number 
AND et.department_Number =2
UNION 
SELECT et.employee_Name , d.department_Name
FROM employee_table et 
INNER JOIN department d 
WHERE et.department_Number = d.department_Number 
AND et.department_Number =3
UNION 
SELECT et.employee_Name , d.department_Name
FROM employee_table et 
INNER JOIN department d 
WHERE et.department_Number = d.department_Number 
AND et.department_Number =4
UNION 
SELECT et.employee_Name , d.department_Name
FROM employee_table et 
INNER JOIN department d 
WHERE et.department_Number = d.department_Number 
AND et.department_Number =5;

/*  Q6 */

SELECT et.employee_Name , count(*) 
FROM employee_table et 
INNER JOIN employss_skill_table est 
WHERE et.employee_Number = est.employee_Number 
GROUP BY est.employee_Number 
HAVING count(est.skill_Code) >1
ORDER BY count(est.skill_Code) DESC ;


/*  Assignment 6  */
















