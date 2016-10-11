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
���~�s��	int identity not null primary key,
�W��		varchar(20) not null,
���O		varchar(10) not null,
)
CREATE TABLE �q��
(
��ڽs�� int identity primary key,
����~�� int not null ,
�Ȥ�s�� int not null ,
�q�ʤ�� date,
foreign key(�Ȥ�s��) references �Ȥ� (�Ȥ�s��),
foreign key(����~��) references ���u (���u�s��),

)
drop table �q�����
CREATE TABLE �q�����
(
���ؽs��    int identity primary key,
��ڽs��	int not null ,
���~�s��	int not null,
�ƶq		int not null,
���		int not null check(���<=2000),--���~������|�W�L2000
�Ƶ�		varchar(50)
foreign key (��ڽs��) references �q�� (��ڽs��),
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

insert into ���~ (�W��,���O)
values	('����1��','�~��'),
		('����2��','�~��'),
		('����3��','�~��'),
		('����4��','�~��'),
		('����5��','�~��'),
		('����6��','����'),
		('����7��','����'),
		('����8��','�T��]'),
		('����9��','�T��]'),
		('����10��','�T��]')

insert into �q�� (����~��,�Ȥ�s��,�q�ʤ��)
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

insert into �q����� 
values	(2,2,5,200,'�ѵM'),
		(3,1,1,100,'�ѵM'),
		(5,1,3,100,''),
		(4,2,1,200,''),
		(1,5,1,500,''),
		(9,7,4,700,''),
		(10,7,1,700,''),
		(8,5,1,500,''),
		(7,7,4,700,''),
		(6,7,1,700,'')

		
-------------------------------------------------------------------------

SELECT *FROM ���u
WHERE ��} LIKE '�x����%'  AND �~�� >30 and �ʧO='�k'
GO


SELECT TOP 3 ����~��,COUNT(*)�P��q��� FROM �q��
GROUP BY ����~��
ORDER BY �P��q��� DESC
GO


SELECT �`��=(�ƶq*���),�Ȥ�W��
FROM �Ȥ� inner join ( ���~ inner join (�q�� inner join �q����� on �q��.��ڽs�� = �q�����.��ڽs��) on ���~.���~�s�� = �q�����.���~�s�� )
on �Ȥ�.�Ȥ�s�� = �q��.�Ȥ�s��  
ORDER BY �`�� DESC
GO
   

SELECT �`��=(�ƶq*���), �Ȥ�.�Ȥ�W��, �Ȥ�.�e�f�a�},�Ȥ�.�p���q��
FROM �Ȥ� inner join ( ���~ inner join (�q�� inner join �q����� on �q��.��ڽs�� = �q�����.��ڽs��) on ���~.���~�s�� = �q�����.���~�s�� )
on �Ȥ�.�Ȥ�s�� = �q��.�Ȥ�s��   
GO


SELECT ���~�s��, COUNT(*)�P��q��� FROM �q�����
GROUP BY ���~�s��
ORDER BY �P��q��� DESC
GO



SELECT �q��.��ڽs��, ���~.���O, �Ȥ�.�Ȥ�W��, �Ȥ�.�e�f�a�},�Ȥ�.�p���q��
FROM �Ȥ� inner join ( ���~ inner join (�q�� inner join �q����� on �q��.��ڽs�� = �q�����.��ڽs��) on ���~.���~�s�� = �q�����.���~�s�� )
on �Ȥ�.�Ȥ�s�� = �q��.�Ȥ�s��  
where ���O='�T��]'
GO
