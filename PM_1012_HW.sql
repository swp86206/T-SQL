
CREATE TABLE �Ȥ��Ʒs�W�B�z
(
�Ȥ�s��  char(6) not null primary key,
�Ȥ�q��  varchar(15) not null check(�Ȥ�q�� like'[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), --�p���q�ܥ����̾� (xx) xxxx-xxxx���榡��J
�e�f�a�}  nvarchar(40) not null, 
�Ȥ�W��  nvarchar(20) not null,
)
go


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

create table

 �Ȥ�s��char (6) �Ȥ�q�� int, �a�} nvarchar(20) , �Ȥ�W�� nvarchar(20)  

 