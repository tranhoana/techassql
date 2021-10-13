USE shipping_example;

CREATE TABLE loaiMatHang(
maLoaiMH varchar(15) PRIMARY KEY,
tenLoaiMH varchar(50)
);
CREATE TABLE khuVuc(
maKhuVuc varchar(15) PRIMARY KEY,
tenKhuVuc varchar(50)
);
CREATE TABLE khachHang(
maKhachHang varchar(15) PRIMARY KEY,
maKhuVuc varchar(15),
tenKhachHang varchar(50),
tenCuaHang varchar(50),
sdtKhachHang int,
diaChiEmail varchar(50),
diaChiNhanHang varchar(100),
CONSTRAINT fk_KH_KV FOREIGN KEY (maKhuVuc)
REFERENCES khuVuc(maKhuVuc)
);

CREATE TABLE dichVu(
maDichVu varchar(15) PRIMARY KEY,
teDichVu varchar(50)
);

CREATE TABLE khoangThoiGian(
maKhoangTG varchar(15) PRIMARY KEY,
moTa varchar(50)
);

CREATE TABLE thanhVienGH(
maThanhVienGH varchar(15) PRIMARY KEY,
tenThanhVienGH varchar(50),
ngaySinh date,
gioiTinh varchar(5) NOT NULL CHECK (gioiTinh IN('Nam','Nu')),
sDTThanhVien int,
diaChiThanhVien varchar(75)
);

CREATE TABLE dangKyGH(
maThanhVienGH varchar(15),
maKhoangTGDKGH varchar(15),
CONSTRAINT fk_DKGH_TG FOREIGN KEY (maKhoangTGDKGH)
REFERENCES khoangThoiGian(maKhoangTG),
CONSTRAINT fk_DKGH_TVGH FOREIGN KEY (maThanhVienGH)
REFERENCES thanhVienGH(maThanhVienGH)
);


CREATE TABLE donHang_GH(
maDonHangGH varchar(15) PRIMARY KEY,
maKhachHang varchar(15),
maThanhVienGH varchar(15),
maDichVu varchar(15),
maKhuVucGH varchar(15),
tenNguoiNhan varchar(50),
diaChiGH varchar(75),
sdtNguoiNhan int,
maKhoangTGGH varchar(15),
ngayGH date,
phuongThucTT varchar(50),
trangThaiPheDuyet varchar(50),
trangThaiGH varchar(50),
CONSTRAINT fk_DHGH_KH FOREIGN KEY (maKhachHang)
REFERENCES khachhang(maKhachHang),
CONSTRAINT fk_DHGH_TVGH FOREIGN KEY (maThanhVienGH)
REFERENCES thanhviengh(maThanhVienGH),
CONSTRAINT fk_DHGH_DV FOREIGN KEY (maDichVu)
REFERENCES dichVu(maDichVu),
CONSTRAINT fk_DHGH_KVGH FOREIGN KEY (maKhuVucGH)
REFERENCES khuVuc(maKhuVuc),
CONSTRAINT fk_DHGH_TG FOREIGN KEY (maKhoangTGGH)
REFERENCES khoangThoiGian(maKhoangTG)
);

CREATE TABLE chiTietDH(
maDonHangGH varchar(15),
tenSanPhamGH varchar(50),
soLuong int,
trongLuong varchar(15),
maLoaiMH varchar(15),
tienThuHo int,
PRIMARY KEY (maDonHangGH,tenSanPhamGH),
CONSTRAINT fk_CTDH_DHGH FOREIGN KEY (maDonHangGH)
REFERENCES donHang_GH(maDonHangGH),
CONSTRAINT fk_CTDH_MH FOREIGN KEY (maLoaiMH)
REFERENCES loaiMatHang(maLoaiMH)
);

/* Câu 1: Xóa những khách hàng có tên là “Le Thi A”. */
/*
DELETE FROM khachhang 
WHERE tenKhachHang LIKE 'Le Thi A';
*/

/* Câu 2: Cập nhật những khách hàng đang thường
 *  trú ở khu vực “Son Tra” thành
 *  khu vực “Ngu Hanh Son”. */

UPDATE khachhang 
SET maKhuVuc = (SELECT maKhuVuc 
FROM khuvuc
WHERE khuvuc.tenKhuVuc LIKE 'Ngu Hanh Son')
WHERE maKhuVuc = (SELECT maKhuVuc 
FROM khuvuc
WHERE khuvuc.tenKhuVuc LIKE 'Son Tra');

/* Câu 3: Liệt kê những nh viên (shipper) 
 * có họ tên bắt đầu là ký tự ‘Tr’ và có độ dài ít nhất 
 * là 25 ký tự (kể cả ký tự trắng).*/

SELECT *
FROM thanhviengh t 
WHERE tenThanhVienGH LIKE 'Tr%'
AND LENGTH(tenThanhVienGH) >25;
 
/* Câu 4: Liệt kê những đơn hàng có NgayGiaoHang 
 * nằm trong năm 2017 và có 
 * khu vực giao hàng là “Hai Chau”.*/
 
SELECT dg.*
FROM donhang_gh dg 
INNER JOIN khuvuc k 
ON dg.maKhuVucGH = k.maKhuVuc 
AND k.tenKhuVuc LIKE 'Hai Chau'
AND YEAR(ngayGH)= 2017;

SELECT dg.*
FROM donhang_gh dg 
WHERE YEAR(ngayGH)= 2017;

/* Câu 5: Liệt kê MaDonHangGiaoHang, MaThanhVienGiaoHang,
 * TenThanhVienGiaoHang, NgayGiaoHang, PhuongThucThanhToan 
 * của tất cả những đơn hàng có trạng thái là “Da giao
 * hang”. Kết quả hiển thị được sắp xếp tăng dần 
 * theo NgayGiaoHang và giảm dần theo
 * PhuongThucThanhToan*/

SELECT dg.maDonHangGH ,dg.maThanhVienGH , t.tenThanhVienGH ,
dg.ngayGH , dg.phuongThucTT 
FROM donhang_gh dg 
INNER JOIN thanhviengh t 
ON dg.maThanhVienGH = t.maThanhVienGH 
AND dg.trangThaiGH LIKE '%Da giao hang%'
ORDER BY dg.ngayGH ASC, dg.phuongThucTT DESC;

/* Câu 6: Liệt kê những thành viên có giới tính là “Nam” 
 * và chưa từng được giao hàng lần nào.*/

SELECT dg.maThanhVienGH 
FROM donhang_gh dg ;

SELECT t.*
FROM thanhviengh t 
WHERE NOT EXISTS (SELECT t.* 
FROM donhang_gh dg
WHERE dg.maThanhVienGH=t.maThanhVienGH)
AND t.gioiTinh LIKE 'Nam';

/* Câu 7: Liệt kê họ tên của những khách hàng đang có trong
 *  hệ thống. Nếu họ tên trùng nhau thì chỉ hiển thị 1 lần.
 *  Học viên cần thực hiện yêu cầu này bằng 2 cách khác nhau
 *  (mỗi cách được tính 0.5 điểm) */


SELECT DISTINCT k.tenKhachHang 
FROM khachhang k 
INNER JOIN donhang_gh dg 
WHERE dg.maKhachHang = k.maKhachHang ; /* Cách 1 : Sử dụng Distinct */

SELECT k.tenKhachHang 
FROM khachhang k 
INNER JOIN donhang_gh dg 
WHERE dg.maKhachHang = k.maKhachHang 
GROUP BY k.tenKhachHang ; /* Cách 2: Nhóm tên khách hàng lại bằng GROUP */

/* Câu 8: Liệt kê MaKhachHang, TenKhachHang, DiaChiNhanHang,
 *  MaDonHangGiaoHang,PhuongThucThanhToan, TrangThaiGiaoHang
 *  của tất cả các khách hàng đang có trong hệ thống*/

SELECT k.maKhachHang , k.tenKhachHang ,
dg.diaChiGH , dg.maDonHangGH ,dg.phuongThucTT ,
dg.trangThaiGH 
FROM khachhang k 
INNER JOIN donhang_gh dg 
ON k.maKhachHang = dg.maKhachHang 
GROUP BY maKhachHang ;

/* Câu 9: Liệt kê những thành viên giao hàng có giới tính là
 *  “Nu” và từng giao hàng cho 10 khách hàng khác nhau ở khu
 *  vực giao hàng là “Hai Chau” */

SELECT dg.maThanhVienGH 
FROM donhang_gh dg 
INNER JOIN khuvuc k 
ON k.maKhuVuc  = dg.maKhuVucGH 
AND k.tenKhuVuc = 'Hai Chau'
GROUP BY dg.maKhachHang 
HAVING count(dg.maKhachHang) >10 ;

SELECT dg.maThanhVienGH ,count(DISTINCT dg.maKhachHang) 
FROM donhang_gh dg 
GROUP BY dg.maThanhVienGH ;

SELECT *
FROM donhang_gh dg ;

SELECT t.*
FROM thanhviengh t
WHERE t.gioiTinh LIKE 'Nu'
AND t.maThanhVienGH IN (SELECT dg.maThanhVienGH 
FROM donhang_gh dg 
INNER JOIN khuvuc k 
ON k.maKhuVuc  = dg.maKhuVucGH 
AND k.tenKhuVuc LIKE 'Hai Chau'
GROUP BY dg.maKhachHang 
HAVING count(dg.maKhachHang) >10);

/* Câu 10: Liệt kê những khách hàng đã từng yêu cầu giao hàng
 *  tại khu vực “Lien Chieu” và chưa từng được một thành viên
 *  giao hàng nào có giới tính là “Nam” nhận giao hàng*/

SELECT DISTINCT dg.maKhachHang 
FROM donhang_gh dg 
INNER JOIN thanhviengh t 
ON dg.maThanhVienGH = t.maThanhVienGH 
AND t.gioiTinh LIKE 'nam'
INNER JOIN khuvuc k 
ON k.maKhuVuc  = dg.maKhuVucGH 
AND k.tenKhuVuc LIKE 'Lien Chieu';


SELECT k.*
FROM khachhang k 
WHERE k.maKhachHang IN ( 
SELECT DISTINCT dg.maKhachHang 
FROM donhang_gh dg 
INNER JOIN thanhviengh t 
ON dg.maThanhVienGH = t.maThanhVienGH 
AND t.gioiTinh LIKE 'nam'
INNER JOIN khuvuc k 
ON k.maKhuVuc  = dg.maKhuVucGH 
AND k.tenKhuVuc LIKE 'Lien Chieu'
);















