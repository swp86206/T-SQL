
CREATE TABLE 客戶資料新增處理
(
客戶編號  char(6) not null primary key,
客戶電話  varchar(15) not null check(客戶電話 like'[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), --聯絡電話必須依據 (xx) xxxx-xxxx的格式輸入
送貨地址  nvarchar(40) not null, 
客戶名稱  nvarchar(20) not null,
)
go


CREATE TRIGGER 處理新增客戶
ON 客戶資料新增處理
INSTEAD OF INSERT
AS
SET NOCOUNT ON

-- 必要時新增客戶資料, 
INSERT 客戶T6 (客戶名稱)
SELECT 客戶名稱
FROM inserted
WHERE  inserted.客戶編號 NOT IN ( SELECT 客戶編號 FROM 客戶T6  )

-- 新增訂單資料
IF @@ROWCOUNT = 0   -- 如果沒有新增客戶
    INSERT 訂單T6 (日期, 客戶編號, 數量, 是否付款)
    SELECT 日期, 客戶編號, 數量, 是否付款
    FROM inserted
ELSE                                   -- 否則以新的客戶編號來更新訂單
    INSERT 訂單T6 (日期, 客戶編號, 數量, 是否付款)
    SELECT 日期, 客戶T6.客戶編號, 數量, 是否付款
    FROM inserted JOIN 客戶T6 ON inserted.客戶名稱 =客戶T6.客戶名稱
GO

INSERT 檢視訂單 (客戶編號, 客戶名稱, 訂單編號, 日期, 數量, 是否付款)
VALUES(9999, '洋洋量販店', 9999, '2008/12/30', 130, 0)
INSERT 檢視訂單 (客戶編號, 客戶名稱, 訂單編號, 日期, 數量, 是否付款)
VALUES(3, 'XXXXX', 9999, '2008/12/30', 130, 0)
GO
SELECT * FROM 訂單T6

GO 

create table

 客戶編號char (6) 客戶電話 int, 地址 nvarchar(20) , 客戶名稱 nvarchar(20)  

 