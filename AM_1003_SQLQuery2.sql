CREATE table �Ȥ�
(
�s��	INT PRIMARY KEY, --�]�w���D��
�m�W	NVARCHAR(50) NOT NULL,
�ʧO	NCHAR(2) DEFAULT '����', --�Ȥ�Q�n����,�G�]2 ;�r��γ�޸�
�~��	INT DEFAULT 25 CHECK (�~��<150),  --CHECK�O�������,�W�L�d��h�X��
�q��	CHAR(14), --�w�]�ONULL,�i����		
�a�}	NVARCHAR(50),
CHECK (�q�� IS NOT NULL OR �a�} IS NOT NULL)  --��̫᭱�@����ƪ��ˬd,�P�_�O���O�ť�
)