CREATE DATABASE quanLyBanHang_baiTap2_ss2;

use quanLyBanHang_baiTap2_ss2;

CREATE TABLE Customer (
    cID INT  PRIMARY KEY,
    cName VARCHAR(255) NOT NULL,
    cAge INT
);

CREATE TABLE Product (
    pID INT  PRIMARY KEY,
    pName VARCHAR(255) NOT NULL,
    pPrice DECIMAL(10, 2) NOT NULL
);

CREATE TABLE `Order` (
    oID INT  PRIMARY KEY,
    cID INT,
    oDate DATE NOT NULL,
    oTotalPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);

CREATE TABLE OrderDetail (
    oID INT,
    pID INT,
    odQTY INT NOT NULL,
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES `Order`(oID),
    FOREIGN KEY (pID) REFERENCES Product(pID)
);
