
CREATE TABLE �Ȥ��Ʒs�W�B�z
(
�Ȥ�s��  char(6) not null primary key,
�Ȥ�q��  varchar(15) not null check(�Ȥ�q�� like'[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), --�p���q�ܥ����̾� (xx) xxxx-xxxx���榡��J
�e�f�a�}  nvarchar(40) not null, 
�Ȥ�W��  nvarchar(20) not null,
)
go


CREATE TRIGGER �B�z�����u
ON ���u�C��
INSTEAD OF UPDATE
AS
	SET NOCOUNT ON
    UPDATE  ���uT1
    SET �m�W  = LEFT( inserted.���u�W��, 
                             CHARINDEX(' ', inserted.���u�W��) -1 ),
            ¾�� = RIGHT( inserted.���u�W��, 
                             LEN( inserted.���u�W��) - CHARINDEX(' ', inserted.���u�W��) )
    FROM inserted 
    WHERE  inserted.���u�s�� = ���uT1.���u�s��
GO

CREATE TRIGGER �B�z�s�W�Ȥ�
ON �Ȥ��Ʒs�W�B�z
INSTEAD OF INSERT
AS
SET NOCOUNT ON

-- ���n�ɷs�W�Ȥ���, 
INSERT �Ȥ�T6 (�Ȥ�W��)
SELECT �Ȥ�W��
FROM inserted
WHERE  inserted.�Ȥ�s�� NOT IN ( SELECT �Ȥ�s�� FROM �Ȥ�T6  )

-- �s�W�q����
IF @@ROWCOUNT = 0   -- �p�G�S���s�W�Ȥ�
    INSERT �q��T6 (���, �Ȥ�s��, �ƶq, �O�_�I��)
    SELECT ���, �Ȥ�s��, �ƶq, �O�_�I��
    FROM inserted
ELSE                                   -- �_�h�H�s���Ȥ�s���ӧ�s�q��
    INSERT �q��T6 (���, �Ȥ�s��, �ƶq, �O�_�I��)
    SELECT ���, �Ȥ�T6.�Ȥ�s��, �ƶq, �O�_�I��
    FROM inserted JOIN �Ȥ�T6 ON inserted.�Ȥ�W�� =�Ȥ�T6.�Ȥ�W��
GO

INSERT �˵��q�� (�Ȥ�s��, �Ȥ�W��, �q��s��, ���, �ƶq, �O�_�I��)
VALUES(9999, '�v�v�q�c��', 9999, '2008/12/30', 130, 0)
INSERT �˵��q�� (�Ȥ�s��, �Ȥ�W��, �q��s��, ���, �ƶq, �O�_�I��)
VALUES(3, 'XXXXX', 9999, '2008/12/30', 130, 0)
GO
SELECT * FROM �q��T6

GO 
--------------------*************************************----------------
create table�@��r�B�z
(
 �Ȥ�s��	char (6),  
 �Ȥ�a�}	nvarchar(20) ,
 �Ȥ�q��	varchar(15),  
 �Ȥ�W��	nvarchar(20)  
)
 
 INSERT ��r�B�z (�Ȥ�s��, �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��)
 VALUES ('TP0001', '�x�_', '02-2222-221', '�Ȥ�@'),
		('TC0001', '�x��', '04-4444-441', '�Ȥ�@'),
		('KH0001', '����', '07-7777-771', '�Ȥ�@')

------------------******************************************-------------

CREATE TRIGGER �B�z�s�W�Ȥ�
ON ��r�B�z
INSTEAD OF INSERT
AS
SET NOCOUNT ON

-- ���n�ɷs�W�Ȥ���, --�S���Ȥ��Ʈɷs�W�Ȥ�
INSERT ��r�B�z (�Ȥ�s��, �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��)
SELECT *
FROM inserted
WHERE  inserted.�Ȥ�s�� NOT IN ( SELECT �Ȥ�s�� FROM ��r�B�z  )
/*
-- �s�W�Ȥ���
IF @@ROWCOUNT = 0   -- �p�G�S���s�W�Ȥ�
    INSERT �q��T6 (���, �Ȥ�s��, �ƶq, �O�_�I��)
    SELECT ���, �Ȥ�s��, �ƶq, �O�_�I��
    FROM inserted
ELSE                                   -- �_�h�H�s���Ȥ�s���ӧ�s�q��
    INSERT �q��T6 (���, �Ȥ�s��, �ƶq, �O�_�I��)
    SELECT ���, �Ȥ�T6.�Ȥ�s��, �ƶq, �O�_�I��
    FROM inserted JOIN �Ȥ�T6 ON inserted.�Ȥ�W�� =�Ȥ�T6.�Ȥ�W��
GO
*/
   -- ���פJ
	INSERT ��r�B�z (�Ȥ�s��, �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��)
	SELECT ��r�B�z.�Ȥ�s��,�Ȥ�a�}, �Ȥ�q��, �Ȥ�W��
	FROM inserted join ��r�B�z on inserted.�Ȥ�a�} = ��r�B�z.�Ȥ�a�}

    -- �ק�A�פJ
	INSERT  ��r�B�z
	select �Ȥ�s�� = LEFT( inserted.�Ȥ�s��,2) + cast (cast(RIGHT( inserted.�Ȥ�s��,4)as int )+1  as varchar), �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��   
				
    FROM inserted 
    --WHERE  inserted.�Ȥ�a�} = ��r�B�z.�Ȥ�a�}
GO

--------------------***************************--------------------------
--���`
 INSERT ��r�B�z (�Ȥ�s��, �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��)
 VALUES ('999999', '�x��', '04-4444-442', '�Ȥ�G')
 INSERT ��r�B�z (�Ȥ�s��, �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��)
 VALUES ('999999', '�x�_', '02-2222-222', '�Ȥ�G')
 INSERT ��r�B�z (�Ȥ�s��, �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��)
 VALUES ('999999', '����', '07-7777-772', '�Ȥ�G')
 --�A�˶���
 INSERT ��r�B�z (�Ȥ�s��, �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��)
 VALUES ('999999', '�x�_', '02-2222-224', '�Ȥ�|')
 INSERT ��r�B�z (�Ȥ�s��, �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��)
 VALUES ('999999', '�x�_', '02-2222-223', '�Ȥ�T')
 --����
 INSERT ��r�B�z (�Ȥ�s��, �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��)
 VALUES ('999999', '����', '07-7777-771', '�Ȥ�@') 
 INSERT ��r�B�z (�Ȥ�s��, �Ȥ�a�}, �Ȥ�q��, �Ȥ�W��)
 VALUES ('999999', '����', '07-7777-772', '�Ȥ�G')

GO
---------------*********************************-----------------
SELECT * FROM ��r�B�z

GO 
------------***************************************-------------



