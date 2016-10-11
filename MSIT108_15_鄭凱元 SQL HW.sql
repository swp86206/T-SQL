--------------------------在master執行
create database stock
on primary
(
NAME='data1',
filename='C:\stock\data1.mdf',
SIZE=10MB,
MAXSIZE=100MB,
filegrowth=20%)
log on
(
NAME='data1_log',
filename='C:\stock\data1_log.ldf'
)


---------------------------
ALTER DATABASE stock add filegroup FILEG2
ALTER DATABASE stock
modify filegroup FILEG2 default


ALTER DATABASE stock add file
(
NAME='data2',
filename='C:\stock\data2.mdf'
)to filegroup FILEG2

ALTER DATABASE stock
modify file 
(NAME='data2',
MAXSIZE=1GB,
filegrowth=10MB
)

-------------------------------------------到stock新增查詢

create table 客戶(
客戶編號 int identity,
客戶名稱 nvarchar(100) NOT NULL, 
聯絡電話 NCHAR(13)  NOT NULL check (聯絡電話 like '[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
送貨地址 nvarchar(100) NOT NULL,
信用額度 money not null,
primary key(客戶編號)
)

create table 員工(
員工編號 int identity,
員工姓名 nvarchar(100) NOT NULL, 
性別 nchar(1) not null check(性別='男' or 性別='女'),
出生日期 date not null check (DATEDIFF(year,出生日期,getdate())<=50 and DATEDIFF(year,出生日期,getdate()) >16),
電話 NCHAR(13)  NOT NULL check (電話 like '[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
住址 nchar(100) not null,
到職日 date not null check (到職日<=getdate()),
薪資 money default 25000 not null,
職位 nchar(10)
primary key(員工編號)
)


create table 產品(
產品編號 int identity,
名稱 NVARCHAR(100) not null,
數量 int not null,
類別 nvarchar(10) not null,
單價 money not null check(單價 < 2000)
primary key(產品編號)
)

create table 訂單(
訂單編號 int identity,
客戶編號 int not null,
訂購日期 date not null,
業務編號 int not null,
primary key(訂單編號),
foreign key(客戶編號) references 客戶 (客戶編號),
foreign key(業務編號) references 員工 (員工編號)
)

create table 訂單內容(
項目編號 int identity,
訂單編號 int not null,
產品編號 int not null,
訂購數量 int not null,
備註 NVARCHAR(1000) ,
primary key(項目編號),
foreign key(產品編號) references 產品 (產品編號),
foreign key(訂單編號) references 訂單 (訂單編號)
)

--------------------------------------------------------

insert into 員工
values
('員工A','女','1980/12/20','(04)1235-5678','台中市民權路100號','2000/1/15',31000,'員工'),
('員工B','女','1970/2/22','(04)1241-2647','台中市中山路2號','1999/4/26',38000,'員工'),
('員工C','男','1980/8/30','(04)1615-5931','台中市民族路71號','2007/11/12',28000,'員工'),
('員工D','男','1990/6/19','(04)1123-2495','台中市中港路310號','2010/5/3',26000,'員工'),
('員工E','男','1968/7/7','(04)6036-2359','台中市中華路93號','1980/2/4',81000,'經理')

insert into 客戶
values
('客戶A','(02)9536-1359','台北市凱達格蘭大道1號',1000000),
('客戶B','(04)1216-5539','台中市市府路72號',100000),
('客戶C','(02)2319-1149','台北市中山路141號',500000),
('客戶D','(02)1590-1951','台北市民族路94號',70000),
('客戶E','(04)5323-9603','台中市逢甲路61號',420000)

insert into 產品
values
('紅茶A',100000,'鋁箔包',15),
('紅茶B',50000,'罐裝',25),
('紅茶C',50000,'瓶裝',30),
('奶茶A',100000,'鋁箔包',20),
('奶茶B',50000,'罐裝',35),
('奶茶C',50000,'瓶裝',40),
('綠茶A',50000,'鋁箔包',10),
('綠茶B',50000,'罐裝',20),
('綠茶C',50000,'瓶裝',25),
('心痛的感覺',1000,'瓶裝',1000)

insert into 訂單
values
(5,'2012/11/14',3),
(2,'2013/6/1',1),
(1,'2013/11/17',4),
(1,'2014/1/7',2),
(3,'2014/3/5',1),
(2,'2014/4/1',3),
(2,'2015/12/27',3),
(4,'2016/10/4',4),
(1,'2016/10/10',5),
(4,'2016/10/11',1)

insert into 訂單內容
values
(1,2,150,'請裝箱'),
(1,1,150,'請裝箱'),
(2,5,10,''),
(3,7,500,''),
(3,8,500,''),
(3,1,250,''),
(4,2,50,''),
(4,1,50,''),
(4,3,50,''),
(5,9,350,''),
(5,2,350,''),
(6,4,250,''),
(7,3,1500,''),
(7,1,1000,''),
(8,5,550,''),
(9,10,1000,''),
(9,1,1500,''),
(9,2,1000,''),
(9,3,1000,''),
(9,5,500,''),
(9,7,500,''),
(10,2,50,''),
(10,6,50,'')


--------------------------------------------
1.

select *
from 員工
where 住址 like'%台中市%' and DATEDIFF(year,出生日期,getdate())>30 and 性別='男'

2.

select 業務編號,本月總銷售額=
(
select sum(訂購數量*單價) 
from 訂單內容 join 產品
on 訂單內容.產品編號=產品.產品編號 and 訂單內容.訂單編號=訂單.訂單編號
)
into 暫存1
from 訂單
where DATEDIFF(month,訂購日期,getdate())=0

select 員工.*,暫存1.本月總銷售額
from 員工 join 暫存1
on 員工.員工編號=暫存1.業務編號
order by 本月總銷售額 desc


3.
select 訂單.客戶編號,訂單總額=(
select sum(訂購數量*單價) 
from 訂單內容 join 產品
on 訂單內容.產品編號=產品.產品編號 and 訂單.訂單編號=訂單內容.訂單編號
)
into 暫存2
from 訂單

select 客戶.客戶編號,客戶.客戶名稱,客戶訂購總額=(
select sum(訂單總額)
from 暫存2
where 暫存2.客戶編號=客戶.客戶編號)
from 客戶
order by 客戶訂購總額 desc
 
4.
select 訂單.訂單編號,訂單.客戶編號,訂單總額=(
select sum(訂購數量*單價) 
from 訂單內容 join 產品
on 訂單內容.產品編號=產品.產品編號 and 訂單.訂單編號=訂單內容.訂單編號
)
into 暫存3
from 訂單

select 暫存3.訂單編號,暫存3.訂單總額,客戶.客戶名稱,客戶.送貨地址,客戶.聯絡電話
from 客戶 join 暫存3
on 客戶.客戶編號=暫存3.客戶編號

5.

SELECT top 1 名稱 as 銷售最好的產品, 
總數量 = (
SELECT SUM(訂購數量) 
FROM  訂單內容 
WHERE 訂單內容.產品編號 = 產品.產品編號)
FROM   產品
order by 總數量 desc


SELECT top 1 名稱 as 銷售最差的產品, 
總數量 = (
SELECT SUM(訂購數量) 
FROM  訂單內容 
WHERE 訂單內容.產品編號 = 產品.產品編號)
FROM   產品
order by 總數量 asc

6.

SELECT distinct  產品.名稱 as 購買的鋁箔包產品,客戶.客戶名稱, 客戶.聯絡電話, 客戶.送貨地址, 客戶.信用額度

FROM   客戶 INNER JOIN
 訂單 ON 客戶.客戶編號 = 訂單.客戶編號 INNER JOIN
 訂單內容 ON 訂單.訂單編號 = 訂單內容.訂單編號 INNER JOIN
 產品 ON 訂單內容.產品編號 = 產品.產品編號

where 產品.類別='鋁箔包'


