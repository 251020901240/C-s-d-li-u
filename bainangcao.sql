CREATE DATABASE IF NOT EXISTS Classicmodels
CHARACTER SET utf8
COLLATE utf8_general_ci;
USE Classicmodels;
SELECT *
FROM orders
WHERE MONTH(orderDate)=4
AND YEAR(orderDate)=2005
AND status='Shipped';

SELECT customerNumber,
       COUNT(*) AS SoDonHang
FROM orders
WHERE status='Shipped'
GROUP BY customerNumber
ORDER BY SoDonHang DESC
LIMIT 1;
SELECT productCode,
       productName,
       quantityInStock
FROM products
WHERE quantityInStock NOT BETWEEN 1000 AND 2000;

SELECT productCode,
       productName,
       quantityInStock
FROM products
WHERE quantityInStock BETWEEN 1000 AND 2000
AND productLine='Ships';
SELECT customerName
FROM customers
WHERE customerName LIKE 'A%';
SELECT country,
       COUNT(customerNumber) AS SoKhachHang
FROM customers
GROUP BY country;
SELECT country,
       SUM(creditLimit) AS TongCreditLimit
FROM customers
GROUP BY country
ORDER BY TongCreditLimit DESC
LIMIT 1;
SELECT customerNumber,
       SUM(amount) AS TongTien
FROM payments
GROUP BY customerNumber;
SELECT customerNumber,
       SUM(amount) AS TongTien,
       COUNT(*) AS SoLanTra
FROM payments
GROUP BY customerNumber
HAVING SUM(amount)<90000
AND COUNT(*)>2;
SELECT SUM(amount) AS TongTien
FROM payments
WHERE MONTH(paymentDate)=11
AND YEAR(paymentDate)=2004;
SELECT customerNumber,
       SUM(amount) AS TongTien
FROM payments
WHERE MONTH(paymentDate)=11
AND YEAR(paymentDate)=2004
GROUP BY customerNumber
ORDER BY TongTien DESC
LIMIT 1;
SELECT MONTH(orderDate) AS Thang,
       COUNT(orderNumber) AS SoLuongDon
FROM orders
WHERE YEAR(orderDate)=2004
GROUP BY MONTH(orderDate)
ORDER BY Thang;
SELECT c.customerName,
       COUNT(o.orderNumber) AS SoDonHang
FROM customers c
JOIN orders o
ON c.customerNumber=o.customerNumber
WHERE YEAR(o.orderDate)=2004
GROUP BY c.customerNumber
ORDER BY SoDonHang DESC
LIMIT 1;
SELECT c.customerName,
       p.productName
FROM customers c

JOIN orders o
ON c.customerNumber=o.customerNumber

JOIN orderdetails od
ON o.orderNumber=od.orderNumber

JOIN products p
ON od.productCode=p.productCode

WHERE MONTH(o.orderDate)=5
AND YEAR(o.orderDate)=2005;
SELECT productCode,
       productName
FROM products
WHERE productCode IN
(
    SELECT productCode
    FROM orderdetails
    WHERE orderNumber IN
    (
        SELECT orderNumber
        FROM orders
        WHERE MONTH(orderDate)=3
        AND YEAR(orderDate)=2005
        AND status='Shipped'
    )
);
CREATE DATABASE IF NOT EXISTS QuanLyDiem
CHARACTER SET utf8;

USE QuanLyDiem;
CREATE TABLE Khoa
(
    MaKhoa VARCHAR(10) PRIMARY KEY,
    TenKhoa VARCHAR(50),
    MaGV_TruongKhoa VARCHAR(10)
);
CREATE TABLE SinhVien
(
    MaSV VARCHAR(10) PRIMARY KEY,
    HoTen VARCHAR(50),
    GioiTinh VARCHAR(10),
    NgaySinh DATE,
    DiaChi VARCHAR(50),
    MaLop VARCHAR(20),
    MaKhoa VARCHAR(10),

    CONSTRAINT FK_SinhVien_Khoa
    FOREIGN KEY(MaKhoa)
    REFERENCES Khoa(MaKhoa)
);
INSERT INTO Khoa
VALUES
(
'CNTT',
'Công nghệ thông tin',
'PU001'
);
INSERT INTO SinhVien
VALUES
(
'001',
'Nguyen Van A',
'Nam',
'2001-01-02',
'Hà Nội',
'CSDL',
'CNTT'
);
SELECT *
FROM SinhVien sv
JOIN Khoa k
ON sv.MaKhoa=k.MaKhoa;