select * from �q��

select * from �Ȥ�

------------------------------�}�d�����n
select �q��.* ,�Ȥ�.*
 from �q��,�Ȥ�
 where �q��.�Ȥ�s�� = �Ȥ�.�Ȥ�s��

 ------------------------------- JOIN
 select �q��.* ,�Ȥ�.*
 from �q�� inner join �Ȥ�
 on �q��.�Ȥ�s�� = �Ȥ�.�Ȥ�s��

 select [�q��s��],[�U����],[�Ȥ�W��],[�q��]
 from �q�� inner join �Ȥ�
 on �q��.�Ȥ�s�� = �Ȥ�.�Ȥ�s��  --  ����۵�,�����X
 ---------------------------------------

select * from �X�X���q

select * from �мФ��q

select �X�X���q.���~�W��, �X�X���q.���� as �X�X���,�мФ��q.���� AS �ма��
from �X�X���q left join �мФ��q
on �X�X���q.���~�W�� = �мФ��q.���~�W��

select �мФ��q.���~�W��, �X�X���q.���� as �X�X���,�мФ��q.���� AS �ма��
from �X�X���q right join �мФ��q
on �X�X���q.���~�W�� = �мФ��q.���~�W��

select �X�X���q.���~�W��, �X�X���q.���� as �X�X���,�мФ��q.���� AS �ма��
from �X�X���q inner join �мФ��q
on �X�X���q.���~�W�� = �мФ��q.���~�W��

select �X�X���q.���~�W��, �X�X���q.���� as �X�X���,�мФ��q.���~�W��,�мФ��q.���� AS �ма��
from �X�X���q full join �мФ��q
on �X�X���q.���~�W�� = �мФ��q.���~�W��
----------------------------------------------------------
select �X�X���q.���~�W��, �X�X���q.���� as �X�X���,�мФ��q.���� AS �ма��
from �X�X���q, �мФ��q
where �X�X���q.���~�W�� = �мФ��q.���~�W��
---------------------------------------------------

select * from ���u

select A.�s��,A.�m�W,A.�ʧO,A.�a�},A.�q��,A.¾��,ISNULL (B.�m�W,'�L') as �D�ަW��
from ���u as A left join ���u as B 
on A.�D�޽s�� = B.�s�� 
