	create database quanLyBanHang_baiTap2_ss2;

	use quanLyBanHang_baiTap2_ss2;

	create table Customer(
	cID varchar(20) primary key,
	cName varchar(200),
	cAge int
	);

	create  table Orders(
	oID varchar(20) primary key ,
	cID varchar(20),
	oDate datetime,
	oTotalPrice float
	);

	create table Product(
	pID varchar(20) primary key,
	pName varchar(200),
	pPrice float
	);

	create table OrderDetail (
	oID varchar(20) ,
	pID varchar(20) ,
	odTY varchar(100),
	primary key(oID,pID)
	);

