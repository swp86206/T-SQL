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
CREATE TABLE �Ȥ�
(
�Ȥ�s��  int identity primary key,
�Ȥ�W��	nvarchar(20) not null,
�p���q��  varchar(15) not null check(�p���q�� like'[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), --�p���q�ܥ����̾� (xx) xxxx-xxxx���榡��J
�e�f�a�}  nvarchar(40) not null, 
�H���B��  int not null
)
CREATE TABLE ���u
(
���u�s��	int identity primary key,
���u�m�W    nvarchar(10) not null,
�ʧO		nchar(1) not null check(�ʧO='�k' or �ʧO='�k'), --  �ʧO�u��O�k�Τk
�X�ͤ��    date not null,
�~��		int not null check ((�~��>16)and(�~��<50)),
�q��		varchar(15) not null check(�q�� like'[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), --�p���q�ܥ����̾� (xx) xxxx-xxxx���榡��J
��}		nvarchar(40) not null, 
��¾��		date not null check(��¾�� <= getdate()), --��¾�餣��b���Ѥ���
�~��		int default 25000, --�~��w�]�_�~��25000
¾��		varchar (5) not null
)
CREATE TABLE ���~
(
���~�s��	int identity primary key,
�W��		varchar(20) not null,
�ƶq		int not null,
���O		varchar(10) not null,
���		int not null check(���<=2000),--���~������|�W�L2000
�`��		as �ƶq* ���,
�Ƶ�		varchar(50)
)
CREATE TABLE �q��
(
��ڽs�� char(20) not null primary key,
����~�� int not null ,
�Ȥ�s�� int not null ,
���~�s�� int not null,
�q�ʤ�� date,
foreign key(�Ȥ�s��) references �Ȥ� (�Ȥ�s��),
foreign key(����~��) references ���u (���u�s��),
foreign key(���~�s��) references ���~ (���~�s��),
)

----------------------------------------------------------------

insert into ���u (���u�m�W,�ʧO,�X�ͤ��,�~��,�q��,��},��¾��,�~��,¾��)
values	('���@��','�k','1970/01/06','46','(04)2222-8888','�x�����F��','2000/2/20',55000,'�g�z'),
		('���G��','�k','1990/3/10','26','(04)2222-8887','�x�������','2013/6/02',42000,'�D��'),
		('���T��','�k','1989/2/15','27','(04)2222-8886','�x�����n��','2015/7/21',35000,'�ժ�'),
		('���p��','�k','1991/5/22','25','(04)2222-8885','�x�����n��','2016/3/23',30000,'�~��'),
		('������','�k','1991/6/17','25','(04)2222-8883','�x�����_��','2016/7/12',27000,'�~��')

insert into �Ȥ� (�Ȥ�W��,�p���q��,�e�f�a�},�H���B��)
values	('10�P','(04)2285-2210','�x��������',31000),
		('20�P','(04)2385-2220','�x�����n�ٰ�',32000),
		('30�P','(04)2285-2230','�x������ٰ�',33000),
		('60�P','(04)2285-2260','�x�����_�ٰ�',36000),
		('90�P','(04)2285-2290','�x��������',39000)

insert into ���~ (�W��,�ƶq,���O,���,�Ƶ�)
values	('����1��',1,'�~��',10,'�ѵM'),
		('����2��',2,'�~��',20,'�Ƥu'),
		('����3��',3,'�~��',30,'�Ƥu'),
		('����4��',4,'�~��',40,'�Ƥu'),
		('����5��',5,'�~��',50,'�ѵM'),
		('����6��',6,'����',60,'�ѵM'),
		('����7��',7,'����',70,'�Ƥu'),
		('����8��',8,'�T��]',80,'�ѵM'),
		('����9��',9,'�T��]',90,'�ѵM'),
		('����10��',9,'�T��]',90,'�Ƥu')

insert into �q�� (��ڽs��,����~��,�Ȥ�s��,���~�s��,�q�ʤ��)
values	(1,1,1,2,'2016/08/01'),
		(2,2,2,5,'2016/08/02'),
		(3,1,3,5,'2016/08/03'),
		(4,1,3,6,'2016/08/04'),
		(5,2,2,3,'2016/08/05'),
		(6,5,3,3,'2016/08/06'),
		(7,1,2,7,'2016/08/07'),
		(8,2,1,7,'2016/08/08'),
		(9,3,1,9,'2016/08/09'),
		(10,5,1,3,'2016/08/10')

-------------------------------------------------------------------------

SELECT *FROM ���u
WHERE ��} LIKE '�x����%'  AND �~�� >30 and �ʧO='�k'
GO


SELECT TOP 3 ����~��,COUNT(*)�P��q��� FROM �q��
GROUP BY ����~��
ORDER BY �P��q��� DESC
GO


SELECT �`��,�Ȥ�W��
FROM �Ȥ� inner join ( �q�� inner join ���~ on �q��.���~�s�� = ���~.���~�s��)
on �Ȥ�.�Ȥ�s�� = �q��.�Ȥ�s��  
ORDER BY �`�� DESC
GO
   

SELECT �q��.��ڽs��, ���~.�`��, �Ȥ�.�Ȥ�W��, �Ȥ�.�e�f�a�},�Ȥ�.�p���q��
FROM �Ȥ� inner join ( �q�� inner join ���~ on �q��.���~�s�� = ���~.���~�s��)
on �Ȥ�.�Ȥ�s�� = �q��.�Ȥ�s��  
GO


SELECT ���~�s��, COUNT(*)�P��q��� FROM �q��
GROUP BY ���~�s��
ORDER BY �P��q��� DESC
GO



SELECT �q��.��ڽs��, ���~.���O, �Ȥ�.�Ȥ�W��, �Ȥ�.�e�f�a�},�Ȥ�.�p���q��
FROM �Ȥ� inner join ( �q�� inner join ���~ on �q��.���~�s�� = ���~.���~�s��)
on �Ȥ�.�Ȥ�s�� = �q��.�Ȥ�s��  
where ���O='�T��]'
GO
