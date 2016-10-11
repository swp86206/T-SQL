create database stock
ON PRIMARY
(
NAME = stock1 , 
FILENAME = 'C:\stock\data1.mdf',
SIZE = 10MB,
MAXSIZE = 100MB ,
FILEGROWTH = 20%
),
FILEGROUP FILEG2
(
NAME = stock2 , 
FILENAME = 'C:\stock\data2.ndf',
SIZE = 10MB,
MAXSIZE = 1GB ,
FILEGROWTH = 10MB
)
LOG ON 
(
NAME = stock , 
FILENAME = 'C:\stock\log.ldf'
)
-----------------------------------
USE stock
CREATE TABLE 客戶
(
客戶編號  int identity primary key,
客戶名稱	nvarchar(20) not null,
聯絡電話  varchar(15) not null check(聯絡電話 like'[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), --聯絡電話必須依據 (xx) xxxx-xxxx的格式輸入
送貨地址  nvarchar(40) not null, 
信用額度  int not null
)
CREATE TABLE 員工
(
員工編號	int identity primary key,
員工姓名    nvarchar(10) not null,
性別		nchar(1) not null check(性別='男' or 性別='女'), --  性別只能是男或女
出生日期    date not null,
年齡		int not null check ((年齡>16)and(年齡<50)),
電話		varchar(15) not null check(電話 like'[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), --聯絡電話必須依據 (xx) xxxx-xxxx的格式輸入
住址		nvarchar(40) not null, 
到職日		date not null check(到職日 <= getdate()), --到職日不能在今天之後
薪資		int default 25000, --薪資預設起薪為25000
職位		varchar (5) not null
)


CREATE TABLE 產品
(
產品編號	int identity not null primary key,
名稱		varchar(20) not null,
類別		varchar(10) not null,
)
CREATE TABLE 訂單
(
單據編號 int identity primary key,
接單業務 int not null ,
客戶編號 int not null ,
訂購日期 date,
foreign key(客戶編號) references 客戶 (客戶編號),
foreign key(接單業務) references 員工 (員工編號),

)
drop table 訂單明細
CREATE TABLE 訂單明細
(
項目編號    int identity primary key,
單據編號	int not null ,
產品編號	int not null,
數量		int not null,
單價		int not null check(單價<=2000),--產品單價不會超過2000
備註		varchar(50)
foreign key (單據編號) references 訂單 (單據編號),
foreign key(產品編號) references 產品 (產品編號),
)




----------------------------------------------------------------

insert into 員工 (員工姓名,性別,出生日期,年齡,電話,住址,到職日,薪資,職位)
values	('王一明','男','1970/01/06','46','(04)2222-8888','台中市東區','2000/2/20',55000,'經理'),
		('王二明','男','1990/3/10','26','(04)2222-8887','台中式西區','2013/6/02',42000,'主任'),
		('王三明','男','1989/2/15','27','(04)2222-8886','台中市南區','2015/7/21',35000,'組長'),
		('王小華','女','1991/5/22','25','(04)2222-8885','台中市南區','2016/3/23',30000,'業務'),
		('王五明','男','1991/6/17','25','(04)2222-8883','台中市北區','2016/7/12',27000,'業務')

insert into 客戶 (客戶名稱,聯絡電話,送貨地址,信用額度)
values	('10嵐','(04)2285-2210','台中市中區',31000),
		('20嵐','(04)2385-2220','台中市南屯區',32000),
		('30嵐','(04)2285-2230','台中市西屯區',33000),
		('60嵐','(04)2285-2260','台中市北屯區',36000),
		('90嵐','(04)2285-2290','台中市中區',39000)

insert into 產品 (名稱,類別)
values	('奶茶1號','瓶裝'),
		('奶茶2號','瓶裝'),
		('奶茶3號','瓶裝'),
		('奶茶4號','瓶裝'),
		('奶茶5號','瓶裝'),
		('奶茶6號','罐裝'),
		('奶茶7號','罐裝'),
		('奶茶8號','鋁箔包'),
		('奶茶9號','鋁箔包'),
		('奶茶10號','鋁箔包')

insert into 訂單 (接單業務,客戶編號,訂購日期)
values	(1,1,'2016/08/01'),
		(2,2,'2016/08/02'),
		(3,1,'2016/08/03'),
		(4,1,'2016/08/04'),
		(5,2,'2016/08/05'),
		(3,5,'2016/08/06'),
		(3,1,'2016/08/07'),
		(5,2,'2016/08/08'),
		(5,3,'2016/08/09'),
		(3,5,'2016/08/10')

insert into 訂單明細 
values	(2,2,5,200,'天然'),
		(3,1,1,100,'天然'),
		(5,1,3,100,''),
		(4,2,1,200,''),
		(1,5,1,500,''),
		(9,7,4,700,''),
		(10,7,1,700,''),
		(8,5,1,500,''),
		(7,7,4,700,''),
		(6,7,1,700,'')

		
-------------------------------------------------------------------------

SELECT *FROM 員工
WHERE 住址 LIKE '台中市%'  AND 年齡 >30 and 性別='男'
GO


SELECT TOP 3 接單業務,COUNT(*)銷售訂單數 FROM 訂單
GROUP BY 接單業務
ORDER BY 銷售訂單數 DESC
GO


SELECT 總價=(數量*單價),客戶名稱
FROM 客戶 inner join ( 產品 inner join (訂單 inner join 訂單明細 on 訂單.單據編號 = 訂單明細.單據編號) on 產品.產品編號 = 訂單明細.產品編號 )
on 客戶.客戶編號 = 訂單.客戶編號  
ORDER BY 總價 DESC
GO
   

SELECT 總價=(數量*單價), 客戶.客戶名稱, 客戶.送貨地址,客戶.聯絡電話
FROM 客戶 inner join ( 產品 inner join (訂單 inner join 訂單明細 on 訂單.單據編號 = 訂單明細.單據編號) on 產品.產品編號 = 訂單明細.產品編號 )
on 客戶.客戶編號 = 訂單.客戶編號   
GO


SELECT 產品編號, COUNT(*)銷售訂單數 FROM 訂單明細
GROUP BY 產品編號
ORDER BY 銷售訂單數 DESC
GO



SELECT 訂單.單據編號, 產品.類別, 客戶.客戶名稱, 客戶.送貨地址,客戶.聯絡電話
FROM 客戶 inner join ( 產品 inner join (訂單 inner join 訂單明細 on 訂單.單據編號 = 訂單明細.單據編號) on 產品.產品編號 = 訂單明細.產品編號 )
on 客戶.客戶編號 = 訂單.客戶編號  
where 類別='鋁箔包'
GO
