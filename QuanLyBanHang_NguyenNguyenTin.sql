

CREATE TABLE LOAIHANG (
    MALOAIHANG VARCHAR(50) PRIMARY KEY,
    TENLOAIHANG VARCHAR(50)
);

CREATE TABLE MATHANG (
    MAHANG VARCHAR(50) PRIMARY KEY,
    TENHANG VARCHAR(50),
    MACONGTY VARCHAR(50),
    MALOAIHANG VARCHAR(50),
    SOLUONG INT,
    DONVITINH VARCHAR(50),
    GIAHANG FLOAT,
    FOREIGN KEY (MALOAIHANG) REFERENCES LOAIHANG(MALOAIHANG)
);

CREATE TABLE NHACUNGCAP (
    MACONGTY VARCHAR(50) PRIMARY KEY,
    TENCONGTY VARCHAR(50),
    TENGIAODICH VARCHAR(50),
    DIACHI VARCHAR(50),
    DIENTHOAI VARCHAR(50),
    FAX VARCHAR(50),
    EMAIL VARCHAR(50)
);

CREATE TABLE CHITIETDATHANG (
    SOHOADON INT,
    MAHANG VARCHAR(50),
    GIABAN FLOAT,
    SOLUONG INT,
    MUCGIAMGIA FLOAT,
    PRIMARY KEY(SOHOADON, MAHANG),
    FOREIGN KEY (MAHANG) REFERENCES MATHANG(MAHANG)
);

CREATE TABLE NHANVIEN (
    MANHANVIEN VARCHAR(50) PRIMARY KEY,
    HO VARCHAR(10),
    TEN VARCHAR(10),
    NGAYSINH DATETIME,
    NGAYLAMVIEC DATETIME,
    DIACHI VARCHAR(50),
    DIENTHOAI VARCHAR(50),
    LUONGCOBAN FLOAT,
    PHUCAP FLOAT
);

CREATE TABLE KHACHHANG (
    MAKHACHHANG VARCHAR(50) PRIMARY KEY,
    TENCONGTY VARCHAR(50),
    TENGIAODICH VARCHAR(50),
    DIACHI VARCHAR(50),
    EMAIL VARCHAR(50),
    DIENTHOAI VARCHAR(50),
    FAX VARCHAR(50)
);

CREATE TABLE DONDATHANG (
    SOHOADON INT PRIMARY KEY,
    MAKHACHHANG VARCHAR(50),
    MANHANVIEN VARCHAR(50),
    NGAYDATHANG DATETIME,
    NGAYGIAOHANG DATETIME,
    NGAYCHUYENHANG DATETIME,
    NOIGIAOHANG VARCHAR(50),
    FOREIGN KEY (MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN),
    FOREIGN KEY (MAKHACHHANG) REFERENCES KHACHHANG(MAKHACHHANG)
);

-- 1
SELECT macongty, tencongty, tengiaodich 
FROM nhacungcap;

-- 2 
SELECT mahang, tenhang, soluong
FROM mathang;

-- 3
SELECT ho, ten, YEAR(ngaylamviec) AS namlamviec 
FROM nhanvien;

-- 4 
SELECT diachi, dienthoai 
FROM nhacungcap 
WHERE tengiaodich = 'VINAMILK';

-- 5. 
SELECT mahang, tenhang 
FROM mathang 
WHERE giahang > 100000 AND soluong < 50;

-- 6. 
SELECT mahang, tenhang, nhacungcap.macongty, tencongty, tengiaodich
FROM mathang 
INNER JOIN nhacungcap ON mathang.macongty = nhacungcap.macongty;

-- 7. 
SELECT mahang, tenhang 
FROM mathang 
INNER JOIN nhacungcap ON mathang.macongty = nhacungcap.macongty 
WHERE tencongty = 'Viet Tien';

-- 8. 
SELECT DISTINCT nhacungcap.macongty, tencongty, diachi
FROM (loaihang 
INNER JOIN mathang ON loaihang.maloaihang = mathang.maloaihang) 
INNER JOIN nhacungcap ON mathang.macongty = nhacungcap.macongty 
WHERE tenloaihang = 'Viet Tien';

-- 9.
SELECT DISTINCT tengiaodich 
FROM ((mathang 
INNER JOIN chitietdathang ON mathang.mahang = chitietdathang.mahang) 
INNER JOIN dondathang ON chitietdathang.sohoadon = dondathang.sohoadon) 
INNER JOIN khachhang ON dondathang.makhachhang = khachhang.makhachhang 
WHERE tenhang = 'Sua Hop';

-- 10. 
SELECT dondathang.manhanvien, ho, ten, ngaygiaohang, noigiaohang
FROM nhanvien 
INNER JOIN dondathang ON nhanvien.manhanvien = dondathang.manhanvien
WHERE sohoadon = 1;

-- 11. 
SELECT manhanvien, ho, ten, luongcoban + IFNULL(phucap, 0) AS luong FROM nhanvien;

-- 12. 
SELECT a.mahang, tenhang, a.soluong * giaban * (1 - giahang / 100) AS sotien 
FROM chitietdathang AS a 
INNER JOIN mathang AS b ON a.mahang = b.mahang;

-- 13. 
SELECT makhachhang, khachhang.tencongty, khachhang.tengiaodich
FROM khachhang 
INNER JOIN nhacungcap ON khachhang.tengiaodich = nhacungcap.tengiaodich;

-- 14. 
SELECT a.ho, a.ten, b.ho, b.ten, b.ngaysinh 
FROM nhanvien a 
INNER JOIN nhanvien b ON a.ngaysinh = b.ngaysinh AND a.manhanvien <> b.manhanvien;

-- 15. 
SELECT sohoadon, tencongty, tengiaodich, ngaydathang, noigiaohang
FROM dondathang 
INNER JOIN khachhang ON dondathang.noigiaohang = khachhang.diachi;

-- 16
SELECT TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI
FROM KHACHHANG  
UNION 
SELECT TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI
FROM NHACUNGCAP;

-- 17
SELECT MAHANG, TENHANG 
FROM MATHANG
WHERE NOT EXISTS
(SELECT MAHANG 
FROM CHITIETDATHANG
WHERE MAHANG = MATHANG.MAHANG);

-- 18
SELECT MANHANVIEN, HO, TEN 
FROM NHANVIEN 
WHERE NOT EXISTS
(SELECT MANHANVIEN 
FROM DONDATHANG 
WHERE MANHANVIEN = NHANVIEN.MANHANVIEN);

-- 19
SELECT MANHANVIEN, HO, TEN, LUONGCOBAN 
FROM NHANVIEN
WHERE LUONGCOBAN = (SELECT MAX(LUONGCOBAN) FROM NHANVIEN);

-- 20
SELECT DONDATHANG.SOHOADON, DONDATHANG.MAKHACHHANG, TENCONGTY, TENGIAODICH, SUM(SOLUONG * GIABAN - SOLUONG * GIABAN * MUCGIAMGIA / 100) 
FROM (KHACHHANG 
INNER JOIN DONDATHANG ON KHACHHANG.MAKHACHHANG = DONDATHANG.MAKHACHHANG) 
INNER JOIN CHITIETDATHANG ON DONDATHANG.SOHOADON = CHITIETDATHANG.SOHOADON 
GROUP BY DONDATHANG.MAKHACHHANG, TENCONGTY, TENGIAODICH, DONDATHANG.SOHOADON;

-- 21
SELECT mathang.mahang, tenhang
FROM (mathang 
INNER JOIN chitietdathang ON mathang.mahang = chitietdathang.mahang) 
INNER JOIN dondathang ON chitietdathang.sohoadon = dondathang.sohoadon 
WHERE YEAR(ngaydathang) = 2003 
GROUP BY mathang.mahang, tenhang 
HAVING COUNT(chitietdathang.mahang) = 1;

-- 22
SELECT khachhang.makhachhang, tencongty, tengiaodich, SUM(soluong * giaban - soluong * giaban * mucgiamgia / 100)
FROM (khachhang 
INNER JOIN dondathang ON khachhang.makhachhang = dondathang.makhachhang) 
INNER JOIN chitietdathang ON dondathang.sohoadon = chitietdathang.sohoadon
GROUP BY khachhang.makhachhang, tencongty, tengiaodich;

-- 23
SELECT nhanvien.manhanvien, ho, ten, COUNT(sohoadon)
FROM nhanvien 
LEFT OUTER JOIN dondathang ON nhanvien.manhanvien = dondathang.manhanvien 
GROUP BY nhanvien.manhanvien, ho, ten;

-- 24
SELECT MONTH(ngaydathang) AS thang, SUM(soluong * giaban - soluong * giaban * mucgiamgia / 100) 
FROM dondathang 
INNER JOIN chitietdathang ON dondathang.sohoadon = chitietdathang.sohoadon 
WHERE YEAR(ngaydathang) = 2003 
GROUP BY MONTH(ngaydathang);

-- 25
SELECT c.mahang, tenhang, SUM(b.soluong * giaban - b.soluong * giaban * mucgiamgia / 100) - SUM(b.soluong * giahang)
FROM (dondathang AS a 
INNER JOIN chitietdathang AS b ON a.sohoadon = b.sohoadon) 
INNER JOIN mathang AS c ON b.mahang = c.mahang 
WHERE YEAR(ngaydathang) = 2003 
GROUP BY c.mahang, tenhang;

-- 26
SELECT mathang.mahang, tenhang, mathang.soluong + IFNULL(SUM(chitietdathang.soluong), 0) AS tongsoluong 
FROM mathang 
LEFT OUTER JOIN chitietdathang ON mathang.mahang = chitietdathang.mahang
GROUP BY mathang.mahang, tenhang, mathang.soluong;

-- 27
SELECT nhanvien.manhanvien, ho, ten, SUM(soluong) 
FROM (nhanvien 
INNER JOIN dondathang ON nhanvien.manhanvien = dondathang.manhanvien) 
INNER JOIN chitietdathang ON dondathang.sohoadon = chitietdathang.sohoadon
GROUP BY nhanvien.manhanvien, ho, ten 
HAVING SUM(soluong) >= ALL
(SELECT SUM(soluong)
FROM (nhanvien 
INNER JOIN dondathang ON nhanvien.manhanvien = dondathang.manhanvien) 
INNER JOIN chitietdathang ON dondathang.sohoadon = chitietdathang.sohoadon
GROUP BY nhanvien.manhanvien, ho, ten);

-- 28
SELECT dondathang.sohoadon, SUM(soluong)
FROM dondathang 
INNER JOIN chitietdathang ON dondathang.sohoadon = chitietdathang.sohoadon
GROUP BY dondathang.sohoadon 
HAVING SUM(soluong) <= ALL
(SELECT SUM(soluong) 
FROM dondathang 
INNER JOIN chitietdathang ON dondathang.sohoadon = chitietdathang.sohoadon
GROUP BY dondathang.sohoadon);

-- 29 
SELECT TOP 1 SUM(soluong * giaban - soluong * giaban * mucgiamgia / 100)
FROM dondathang
INNER JOIN chitietdathang ON dondathang.sohoadon = chitietdathang.sohoadon
ORDER BY 1 DESC;

-- 30 
SELECT a.sohoadon, b.mahang, tenhang, b.soluong * giaban - b.soluong * giaban * mucgiamgia / 100 
FROM (dondathang AS a 
INNER JOIN chitietdathang AS b ON a.sohoadon = b.sohoadon) 
INNER JOIN mathang AS c ON b.mahang = c.mahang 
ORDER BY a.sohoadon
COMPUTE SUM(b.soluong * giaban - b.soluong * giaban * mucgiamgia / 100) BY a.sohoadon;

-- 31
SELECT loaihang.maloaihang, tenloaihang, mahang, tenhang, soluong
FROM loaihang
INNER JOIN mathang ON loaihang.maloaihang = mathang.maloaihang
ORDER BY loaihang.maloaihang
COMPUTE SUM(soluong) BY loaihang.maloaihang
COMPUTE SUM(soluong);

-- 32
SELECT b.mahang, tenhang,
       SUM(CASE MONTH(ngaydathang) WHEN 1 THEN b.soluong ELSE 0 END) AS Thang1,
       SUM(CASE MONTH(ngaydathang) WHEN 2 THEN b.soluong ELSE 0 END) AS Thang2,
       SUM(CASE MONTH(ngaydathang) WHEN 3 THEN b.soluong ELSE 0 END) AS Thang3,
       SUM(CASE MONTH(ngaydathang) WHEN 4 THEN b.soluong ELSE 0 END) AS Thang4,
       SUM(CASE MONTH(ngaydathang) WHEN 5 THEN b.soluong ELSE 0 END) AS Thang5,
       SUM(CASE MONTH(ngaydathang) WHEN 6 THEN b.soluong ELSE 0 END) AS Thang6,
       SUM(CASE MONTH(ngaydathang) WHEN 7 THEN b.soluong ELSE 0 END) AS Thang7,
       SUM(CASE MONTH(ngaydathang) WHEN 8 THEN b.soluong ELSE 0 END) AS Thang8,
       SUM(CASE MONTH(ngaydathang) WHEN 9 THEN b.soluong ELSE 0 END) AS Thang9,
       SUM(CASE MONTH(ngaydathang) WHEN 10 THEN b.soluong ELSE 0 END) AS Thang10,
       SUM(CASE MONTH(ngaydathang) WHEN 11 THEN b.soluong ELSE 0 END) AS Thang11,
       SUM(CASE MONTH(ngaydathang) WHEN 12 THEN b.soluong ELSE 0 END) AS Thang12,
       SUM(b.soluong) AS CaNam
FROM dondathang AS a
INNER JOIN chitietdathang AS b ON a.sohoadon = b.sohoadon
INNER JOIN mathang AS c ON b.mahang = c.mahang
WHERE YEAR(ngaydathang) = 1996
GROUP BY b.mahang, tenhang;

-- 33
UPDATE dondathang
SET ngaychuyenhang = ngaydathang
WHERE ngaychuyenhang IS NULL;

-- 34
UPDATE mathang
SET soluong = soluong * 2
FROM nhacungcap
WHERE nhacungcap.macongty = mathang.macongty AND nhacungcap.tencongty = 'VINAMILK';

-- 35
UPDATE dondathang
SET noigiaohang = khachhang.diachi
FROM khachhang
WHERE dondathang.makhachhang = khachhang.makhachang AND noigiaohang IS NULL;

-- 36
UPDATE khachhang
SET khachhang.diachi = nhacungcap.diachi,
    khachhang.dienthoai = nhacungcap.dienthoai,
    khachhang.fax = nhacungcap.fax,
    khachhang.email = nhacungcap.email
FROM nhacungcap
WHERE khachhang.tencongty = nhacungcap.tencongty AND khachhang.tengiaodich = nhacungcap.tengiaodich;

-- 37
UPDATE nhanvien
SET luongcoban = luongcoban * 1.5
WHERE manhanvien IN (
    SELECT manhanvien
    FROM dondathang
    INNER JOIN chitietdathang ON dondathang.sohoadon = chitietdathang.sohoadon
    WHERE manhanvien = nhanvien.manhanvien
    GROUP BY manhanvien
    HAVING SUM(soluong) > 100
);

-- 38
UPDATE nhanvien
SET phucap = luongcoban / 2
WHERE manhanvien IN (
    SELECT manhanvien
    FROM dondathang
    INNER JOIN chitietdathang ON dondathang.sohoadon = chitietdathang.sohoadon
    GROUP BY manhanvien
    HAVING SUM(soluong) >= ALL (
        SELECT SUM(soluong)
        FROM dondathang
        INNER JOIN chitietdathang ON dondathang.sohoadon = chitietdathang.sohoadon
        GROUP BY manhanvien
    )
);

-- 39
UPDATE nhanvien
SET luongcoban = luongcoban * 0.85
WHERE NOT EXISTS (
    SELECT manhanvien
    FROM dondathang
    WHERE dondathang.manhanvien = nhanvien.manhanvien
);

-- 40
UPDATE dondathang
SET sotien = (
    SELECT SUM(soluong * giaban + soluong * giaban * mucgiamgia)
    FROM chitietdathang
    WHERE sohoadon = dondathang.sohoadon
    GROUP BY sohoadon
);
