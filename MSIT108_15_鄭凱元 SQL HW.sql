--------------------------�bmaster����
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

-------------------------------------------��stock�s�W�d��

create table �Ȥ�(
�Ȥ�s�� int identity,
�Ȥ�W�� nvarchar(100) NOT NULL, 
�p���q�� NCHAR(13)  NOT NULL check (�p���q�� like '[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
�e�f�a�} nvarchar(100) NOT NULL,
�H���B�� money not null,
primary key(�Ȥ�s��)
)

create table ���u(
���u�s�� int identity,
���u�m�W nvarchar(100) NOT NULL, 
�ʧO nchar(1) not null check(�ʧO='�k' or �ʧO='�k'),
�X�ͤ�� date not null check (DATEDIFF(year,�X�ͤ��,getdate())<=50 and DATEDIFF(year,�X�ͤ��,getdate()) >16),
�q�� NCHAR(13)  NOT NULL check (�q�� like '[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
��} nchar(100) not null,
��¾�� date not null check (��¾��<=getdate()),
�~�� money default 25000 not null,
¾�� nchar(10)
primary key(���u�s��)
)


create table ���~(
���~�s�� int identity,
�W�� NVARCHAR(100) not null,
�ƶq int not null,
���O nvarchar(10) not null,
��� money not null check(��� < 2000)
primary key(���~�s��)
)

create table �q��(
�q��s�� int identity,
�Ȥ�s�� int not null,
�q�ʤ�� date not null,
�~�Ƚs�� int not null,
primary key(�q��s��),
foreign key(�Ȥ�s��) references �Ȥ� (�Ȥ�s��),
foreign key(�~�Ƚs��) references ���u (���u�s��)
)

create table �q�椺�e(
���ؽs�� int identity,
�q��s�� int not null,
���~�s�� int not null,
�q�ʼƶq int not null,
�Ƶ� NVARCHAR(1000) ,
primary key(���ؽs��),
foreign key(���~�s��) references ���~ (���~�s��),
foreign key(�q��s��) references �q�� (�q��s��)
)

--------------------------------------------------------

insert into ���u
values
('���uA','�k','1980/12/20','(04)1235-5678','�x�������v��100��','2000/1/15',31000,'���u'),
('���uB','�k','1970/2/22','(04)1241-2647','�x�������s��2��','1999/4/26',38000,'���u'),
('���uC','�k','1980/8/30','(04)1615-5931','�x�������ڸ�71��','2007/11/12',28000,'���u'),
('���uD','�k','1990/6/19','(04)1123-2495','�x���������310��','2010/5/3',26000,'���u'),
('���uE','�k','1968/7/7','(04)6036-2359','�x�������ظ�93��','1980/2/4',81000,'�g�z')

insert into �Ȥ�
values
('�Ȥ�A','(02)9536-1359','�x�_���͹F�����j�D1��',1000000),
('�Ȥ�B','(04)1216-5539','�x����������72��',100000),
('�Ȥ�C','(02)2319-1149','�x�_�����s��141��',500000),
('�Ȥ�D','(02)1590-1951','�x�_�����ڸ�94��',70000),
('�Ȥ�E','(04)5323-9603','�x�����{�Ҹ�61��',420000)

insert into ���~
values
('����A',100000,'�T��]',15),
('����B',50000,'����',25),
('����C',50000,'�~��',30),
('����A',100000,'�T��]',20),
('����B',50000,'����',35),
('����C',50000,'�~��',40),
('���A',50000,'�T��]',10),
('���B',50000,'����',20),
('���C',50000,'�~��',25),
('�ߵh���Pı',1000,'�~��',1000)

insert into �q��
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

insert into �q�椺�e
values
(1,2,150,'�и˽c'),
(1,1,150,'�и˽c'),
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
from ���u
where ��} like'%�x����%' and DATEDIFF(year,�X�ͤ��,getdate())>30 and �ʧO='�k'

2.

select �~�Ƚs��,�����`�P���B=
(
select sum(�q�ʼƶq*���) 
from �q�椺�e join ���~
on �q�椺�e.���~�s��=���~.���~�s�� and �q�椺�e.�q��s��=�q��.�q��s��
)
into �Ȧs1
from �q��
where DATEDIFF(month,�q�ʤ��,getdate())=0

select ���u.*,�Ȧs1.�����`�P���B
from ���u join �Ȧs1
on ���u.���u�s��=�Ȧs1.�~�Ƚs��
order by �����`�P���B desc


3.
select �q��.�Ȥ�s��,�q���`�B=(
select sum(�q�ʼƶq*���) 
from �q�椺�e join ���~
on �q�椺�e.���~�s��=���~.���~�s�� and �q��.�q��s��=�q�椺�e.�q��s��
)
into �Ȧs2
from �q��

select �Ȥ�.�Ȥ�s��,�Ȥ�.�Ȥ�W��,�Ȥ�q���`�B=(
select sum(�q���`�B)
from �Ȧs2
where �Ȧs2.�Ȥ�s��=�Ȥ�.�Ȥ�s��)
from �Ȥ�
order by �Ȥ�q���`�B desc
 
4.
select �q��.�q��s��,�q��.�Ȥ�s��,�q���`�B=(
select sum(�q�ʼƶq*���) 
from �q�椺�e join ���~
on �q�椺�e.���~�s��=���~.���~�s�� and �q��.�q��s��=�q�椺�e.�q��s��
)
into �Ȧs3
from �q��

select �Ȧs3.�q��s��,�Ȧs3.�q���`�B,�Ȥ�.�Ȥ�W��,�Ȥ�.�e�f�a�},�Ȥ�.�p���q��
from �Ȥ� join �Ȧs3
on �Ȥ�.�Ȥ�s��=�Ȧs3.�Ȥ�s��

5.

SELECT top 1 �W�� as �P��̦n�����~, 
�`�ƶq = (
SELECT SUM(�q�ʼƶq) 
FROM  �q�椺�e 
WHERE �q�椺�e.���~�s�� = ���~.���~�s��)
FROM   ���~
order by �`�ƶq desc


SELECT top 1 �W�� as �P��̮t�����~, 
�`�ƶq = (
SELECT SUM(�q�ʼƶq) 
FROM  �q�椺�e 
WHERE �q�椺�e.���~�s�� = ���~.���~�s��)
FROM   ���~
order by �`�ƶq asc

6.

SELECT distinct  ���~.�W�� as �ʶR���T��]���~,�Ȥ�.�Ȥ�W��, �Ȥ�.�p���q��, �Ȥ�.�e�f�a�}, �Ȥ�.�H���B��

FROM   �Ȥ� INNER JOIN
 �q�� ON �Ȥ�.�Ȥ�s�� = �q��.�Ȥ�s�� INNER JOIN
 �q�椺�e ON �q��.�q��s�� = �q�椺�e.�q��s�� INNER JOIN
 ���~ ON �q�椺�e.���~�s�� = ���~.���~�s��

where ���~.���O='�T��]'


