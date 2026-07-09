CREATE DATABASE QLNV;

USE QLNV;

CREATE TABLE PhongBan
(
    MaPB INT PRIMARY KEY,
    TenPB VARCHAR(50) NOT NULL,
    NguoiQuanLy INT
);

CREATE TABLE NhanVien
(
    MaNV INT PRIMARY KEY,
    TenNV VARCHAR(50) NOT NULL,
    NgaySinh DATE,
    DiaChi VARCHAR(50),
    Luong DECIMAL(12,0),
    GioiTinh BOOLEAN,
    MaPB INT
);

CREATE TABLE CongTrinh
(
    MaCT INT PRIMARY KEY,
    TenCT VARCHAR(50) NOT NULL,
    NgayKC DATE DEFAULT (CURRENT_DATE),
    NgayHT DATE,
    DiaDiem VARCHAR(50)
);

CREATE TABLE ThamGia
(
    MaCT INT,
    MaNV INT,
    SoNgayCong INT,
    PRIMARY KEY(MaCT, MaNV)
);

ALTER TABLE NhanVien
ADD CONSTRAINT FK_NhanVien_PhongBan
FOREIGN KEY(MaPB)
REFERENCES PhongBan(MaPB);

ALTER TABLE PhongBan
ADD CONSTRAINT FK_PhongBan_NhanVien
FOREIGN KEY(NguoiQuanLy)
REFERENCES NhanVien(MaNV);

ALTER TABLE ThamGia
ADD CONSTRAINT FK_ThamGia_CongTrinh
FOREIGN KEY(MaCT)
REFERENCES CongTrinh(MaCT);

ALTER TABLE ThamGia
ADD CONSTRAINT FK_ThamGia_NhanVien
FOREIGN KEY(MaNV)
REFERENCES NhanVien(MaNV);

ALTER TABLE NhanVien
ADD CONSTRAINT CK_Luong
CHECK (Luong > 0);

INSERT INTO NhanVien
VALUES
(1,'Nguyen Hai Dang','2000-08-08','Hoa Binh',4000000,1,NULL),
(2,'Tran Cao Ha','2000-09-01','Yen Bai',3500000,1,NULL),
(3,'Hoang Hai Nam','2000-02-20','Ha Noi',2300000,0,NULL),
(4,'Tran Hong Nam','2000-08-07','Nam Dinh',3200000,1,NULL),
(5,'Le Thi Hang','2000-03-04','Thanh Hoa',6700000,0,NULL),
(6,'Nguyen Thi Hang','2000-09-09','Hai Phong',9900000,0,NULL),
(7,'Le Thi Van Anh','2000-03-05','Ha Noi',3500000,0,NULL),
(8,'Ha Van Cam','2000-03-05','Yen Bai',2300000,1,NULL),
(9,'Dinh Hong Nam','2000-08-03','Bac Ninh',6700000,1,NULL),
(10,'Ho Viet Dung','2000-04-02','Nghe An',3500000,1,NULL),
(11,'Tran Duc Nghia','2000-01-01','Ha Noi',9900000,1,NULL);

INSERT INTO PhongBan
VALUES
(1,'Phong phan mem',11),
(2,'Phong kiem thu',5),
(3,'Phong phan cung',4);

UPDATE NhanVien
SET MaPB = 1
WHERE MaNV IN (1,2,3,7,11);

UPDATE NhanVien
SET MaPB = 2
WHERE MaNV IN (4,6);

UPDATE NhanVien
SET MaPB = 3
WHERE MaNV IN (5,8,9,10);

INSERT INTO CongTrinh
(MaCT,TenCT,NgayKC,NgayHT,DiaDiem)
VALUES
(1,'Mobile Contact','2005-08-08','2006-08-08','HITC'),
(2,'Re-Issue','2007-08-06','2007-07-07','FPT Cau Giay'),
(3,'Mobile Contact','2010-01-18','2007-09-09','FPT Cau Giay'),
(4,'Wings','2005-04-28','2005-08-05','FPT Cau Giay');

INSERT INTO ThamGia
VALUES
(1,1,30),
(1,2,25),
(2,4,20),
(2,5,18),
(3,6,40),
(4,8,35);