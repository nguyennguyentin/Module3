CREATE DATABASE quanLyKhoHang_baiTap1_ss2;

use quanLyKhoHang_baiTap1_ss2;

CREATE TABLE PHIEUXUAT (
    SoPX INT PRIMARY KEY,
    NgayXuat DATE
);

CREATE TABLE VATTU (
    MaVTU VARCHAR(255) PRIMARY KEY,
    TenVTU VARCHAR(255),
    DGNhap DECIMAL(10, 2)
);

CREATE TABLE PHIEUNHAP (
    SoPN INT PRIMARY KEY,
    NgayNhap DATE
);

CREATE TABLE DONDH (
    SoDH INT PRIMARY KEY,
    NgayDH DATE
);

CREATE TABLE NHACC (
    MaNCC VARCHAR(255) PRIMARY KEY,
    TenNCC VARCHAR(255),
    DiaChi VARCHAR(255)     
);

CREATE TABLE SDT (
	SDT INT PRIMARY KEY ,
	MaNCC VARCHAR(255) ,
	FOREIGN KEY (MaNCC) REFERENCES NhaCC(MaNCC)
);


CREATE TABLE CHITIET_PHIEUXUAT (
    SoPX INT,
    MaVTU VARCHAR(255),
    DGXuat DECIMAL(10, 2),
    SLXuat INT,
    PRIMARY KEY (SoPX, MaVTU),
    FOREIGN KEY (SoPX) REFERENCES PHIEUXUAT(SoPX),
    FOREIGN KEY (MaVTU) REFERENCES VATTU(MaVTU)
);

CREATE TABLE CHITIET_PHIEUNHAP (
    SoPN INT,
    MaVTU VARCHAR(255),
    DGNhap DECIMAL(10, 2),
    SLNhap INT,
    PRIMARY KEY (SoPN, MaVTU),
    FOREIGN KEY (SoPN) REFERENCES PHIEUNHAP(SoPN),
    FOREIGN KEY (MaVTU) REFERENCES VATTU(MaVTU)
);

CREATE TABLE CHITIET_DONDH (
    SoDH INT,
    MaVTU VARCHAR(255),
    SLDatHang INT,
    PRIMARY KEY (SoDH, MaVTU),
    FOREIGN KEY (SoDH) REFERENCES DONDH(SoDH),
    FOREIGN KEY (MaVTU) REFERENCES VATTU(MaVTU)
);
classclassclass