USE extra2_example;

CREATE TABLE khoa(
makhoa char(10) PRIMARY KEY ,
tenkhoa char(30),
dienthoai char(10)
);
CREATE TABLE giangvien(
magv int PRIMARY KEY AUTO_INCREMENT,
hotengv varchar(30),
luong decimal(5,2),
makhoa char(10),
CONSTRAINT fk_GV_K FOREIGN KEY (makhoa)
REFERENCES khoa(makhoa)
);

CREATE TABLE sinhvien(
masv int PRIMARY KEY AUTO_INCREMENT,
hotensv varchar(30),
makhoa char(10),
namsinh int,
quequan varchar(30),
CONSTRAINT fk_SV_K FOREIGN KEY (makhoa)
REFERENCES khoa(makhoa)
);

CREATE TABLE detai(
madt char(10) PRIMARY KEY ,
tendt varchar(30),
kinhphi int,
noithuctap varchar(30)
);

CREATE TABLE huongdan(
masv int,
madt char(10),
magv int,
ketqua decimal(5,2),
CONSTRAINT fk_HD_SV FOREIGN KEY (masv)
REFERENCES sinhvien(masv),
CONSTRAINT fk_HD_DT FOREIGN KEY (madt)
REFERENCES detai(madt),
CONSTRAINT fk_HD_GV FOREIGN KEY (magv)
REFERENCES giangvien(magv)
);


INSERT INTO khoa 
(makhoa,tenkhoa,dienthoai)
VALUES
('CNTT', 'Cong Nghe Thong Tin', '09999999');

INSERT INTO khoa 
(makhoa,tenkhoa,dienthoai)
VALUES
('MKT', 'Marketing', '08888888');

INSERT INTO khoa 
(makhoa,tenkhoa,dienthoai)
VALUES
('KT', 'Ke Toan', '07777777');
INSERT INTO khoa 
(makhoa,tenkhoa,dienthoai)
VALUES
('DL', 'DIA LY', '0666666');
INSERT INTO khoa 
(makhoa,tenkhoa,dienthoai)
VALUES
('QLTN', 'QUAN LY cai gi day', '055555555');

INSERT INTO giangvien 
(hotengv ,luong ,makhoa)
VALUES
('Do Thanh Quang', '5.5', 'CNTT');
INSERT INTO giangvien 
(hotengv ,luong ,makhoa)
VALUES
('Pham Dac Noi', '5.5', 'CNTT');
INSERT INTO giangvien 
(hotengv ,luong ,makhoa)
VALUES
('Pham Van A', '5.5', 'DL');

INSERT INTO giangvien 
(hotengv ,luong ,makhoa)
VALUES
('Tran Van B', '5.5', 'DL');
INSERT INTO giangvien 
(hotengv ,luong ,makhoa)
VALUES
('Nguyen Thi Cu Cai', '9.5', 'DL');
INSERT INTO giangvien 
(hotengv ,luong ,makhoa)
VALUES
('Pham Linh Chi', '6.5', 'QLTN');
INSERT INTO giangvien 
(hotengv ,luong ,makhoa)
VALUES
('Nguyen Thi Ca Rot', '5.5', 'QLTN');

INSERT INTO sinhvien 
(hotensv,makhoa,namsinh,quequan)
VALUES
('Nguyen Hoan', 'CNTT', 1999, 'Thanh Hoa');

INSERT INTO sinhvien 
(hotensv,makhoa,namsinh,quequan)
VALUES
('Tran Le Nguyen', 'KT', 2006, 'Thanh Hoa');

INSERT INTO detai 
(madt,tendt,kinhphi,noithuctap)
VALUES
('SQL01', 'SQL Basic', 1200000 , 'Thanh Hoa');

INSERT INTO detai 
(madt,tendt,kinhphi,noithuctap)
VALUES
('Java01', 'Java Basic', 1600000 , 'TechAS');

INSERT INTO huongdan 
(masv,madt,magv,ketqua)
VALUES
(1, 'Java01', 1 , '6.5');
INSERT INTO huongdan 
(masv,madt,magv,ketqua)
VALUES
(2, 'SQL01', 2 , '9.5');


/*Mã số, họ tên, tên khoa của giảng viên */

SELECT g.magv ,g.hotengv ,k.tenkhoa 
FROM giangvien g 
INNER JOIN khoa k 
WHERE g.makhoa = k.makhoa 
ORDER BY g.magv ASC;

/* Mã số, họ tên tên khoa của các giảng viên DIALY and QLTN */

SELECT g.magv ,g.hotengv ,k.tenkhoa 
FROM giangvien g 
INNER JOIN khoa k 
WHERE g.makhoa = k.makhoa
AND k.makhoa IN ('DL','QLTN')
ORDER BY g.magv ASC;

/* Cho biết số SV của khoa CNTT */

SELECT count(*)
FROM sinhvien s 
WHERE s.makhoa ='CNTT';

/* Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘Ke Toan’ */

SELECT s.masv, s.hotensv ,s.namsinh 
FROM sinhvien s 
WHERE s.makhoa ='KT';

/*Cho biết số giảng viên của khoa ‘DIA LY*/

SELECT count(*) 
FROM giangvien g
WHERE g.makhoa ='DL';

/* Cho biết thông tin về sinh viên không tham gia thực tập */

SELECT s.*
FROM sinhvien s 
INNER JOIN huongdan h
ON s.masv =h.masv ;

SELECT s.*
FROM sinhvien s 
WHERE NOT EXISTS (SELECT s.*
FROM huongdan h
WHERE s.masv =h.masv );

/* Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa */

SELECT k.makhoa ,k.tenkhoa , count(*) AS 'So luong GV'
FROM khoa k 
INNER JOIN giangvien g 
WHERE k.makhoa = g.makhoa 
GROUP BY g.makhoa ;

/* Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học */

SELECT k.dienthoai 
FROM khoa k 
INNER JOIN sinhvien s 
WHERE k.makhoa = s.makhoa 
AND s.hotensv LIKE '%Le Van Son%';

/*Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn*/

SELECT h.madt 
FROM huongdan h
INNER JOIN giangvien g 
WHERE h.magv = g.magv 
AND g.hotengv LIKE '%Tran Son%';

SELECT d.madt ,d.tendt 
FROM detai d 
INNER JOIN huongdan h
WHERE d.madt = h.madt 
AND h.madt IN (SELECT h.madt 
FROM huongdan h
INNER JOIN giangvien g 
WHERE h.magv = g.magv 
AND g.hotengv LIKE '%Tran Son%'); /* ??? Thêm 1 đáp án SQL 01 ??? */


SELECT DISTINCT d.madt ,d.tendt 
FROM detai d 
INNER JOIN huongdan h
WHERE d.madt = h.madt 
AND h.madt IN (SELECT h.madt 
FROM huongdan h
INNER JOIN giangvien g 
WHERE h.magv = g.magv 
AND g.hotengv LIKE '%Tran Son%');


/* Cho biết tên đề tài không có sinh viên nào thực tập */

SELECT d.madt 
FROM detai d 
INNER JOIN huongdan h
WHERE d.madt =h.madt ;

SELECT d.tendt 
FROM detai d 
WHERE NOT EXISTS (SELECT * 
FROM huongdan h
WHERE d.madt =h.madt );

/* Cho biết mã số, họ tên, tên khoa của các giảng
 *  viên hướng dẫn từ 3 sinh viên trở lên. */

SELECT g.magv , g.hotengv , k.tenkhoa 
FROM giangvien g 
INNER JOIN khoa k ON g.makhoa = k.makhoa 
INNER JOIN huongdan h 
ON h.magv = g.magv
GROUP BY h.magv 
HAVING count(h.magv) >3;

/* Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất */
SELECT d.madt , d.tendt , d.kinhphi 
FROM detai d  
ORDER BY d.kinhphi DESC LIMIT 1;

SELECT d.madt , d.tendt , max(d.kinhphi) 
FROM detai d;  /* Làm sao để dùng hàm max mà không muốn nó
xuất hiện ra trong bảng ??? (Select d.ma, d.ten theo MAX ) */

/* Cho biết mã số và tên các đề tài 
 * có nhiều hơn 2 sinh viên tham gia thực tập
 */

SELECT d.madt , d.tendt 
FROM detai d 
INNER JOIN huongdan h 
ON d.madt =h.madt 
GROUP BY h.madt 
HAVING count(h.madt)>2 
ORDER BY count(h.madt) DESC;

/* Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
 */
 

SELECT s.masv , s.hotensv ,h.ketqua 
FROM sinhvien s 
INNER JOIN huongdan h 
ON s.masv =h.masv 
INNER JOIN khoa k 
ON k.makhoa =s.makhoa 
AND (k.tenkhoa LIKE 'DIA LY' 
OR k.tenkhoa LIKE 'QUAN LY cai gi day');

/* Đưa ra tên khoa, số lượng sinh viên của mỗi khoa */

SELECT k.tenkhoa , count(*)
FROM khoa k 
INNER JOIN sinhvien s 
ON k.makhoa =s.makhoa 
GROUP BY k.makhoa ;

/* Cho biết thông tin về các sinh viên 
 * thực tập tại quê nhà ?????
 */

/* Hãy cho biết thông tin về 
 * những sinh viên chưa có điểm thực tập */
SELECT s.*
FROM sinhvien s 
INNER JOIN huongdan h 
ON h.masv =s.masv 
AND h.ketqua IS NULL;

/* Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0 */

SELECT s.masv ,s.hotensv 
FROM sinhvien s 
INNER JOIN huongdan h 
ON h.masv =s.masv 
AND h.ketqua =0;











