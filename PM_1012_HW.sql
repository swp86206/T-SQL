
CREATE TABLE 客戶資料新增處理
(
客戶編號  char(6) not null primary key,
客戶電話  varchar(15) not null check(客戶電話 like'[(][0-9][0-9][)][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), --聯絡電話必須依據 (xx) xxxx-xxxx的格式輸入
送貨地址  nvarchar(40) not null, 
客戶名稱  nvarchar(20) not null,
)
go


CREATE TRIGGER 處理更改員工
ON 員工列表
INSTEAD OF UPDATE
AS
	SET NOCOUNT ON
    UPDATE  員工T1
    SET 姓名  = LEFT( inserted.員工名稱, 
                             CHARINDEX(' ', inserted.員工名稱) -1 ),
            職稱 = RIGHT( inserted.員工名稱, 
                             LEN( inserted.員工名稱) - CHARINDEX(' ', inserted.員工名稱) )
    FROM inserted 
    WHERE  inserted.員工編號 = 員工T1.員工編號
GO

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
--------------------*************************************----------------
create table　文字處理
(
 客戶編號	char (6),  
 客戶地址	nvarchar(20) ,
 客戶電話	varchar(15),  
 客戶名稱	nvarchar(20)  
)
 
 INSERT 文字處理 (客戶編號, 客戶地址, 客戶電話, 客戶名稱)
 VALUES ('TP0001', '台北', '02-2222-221', '客戶一'),
		('TC0001', '台中', '04-4444-441', '客戶一'),
		('KH0001', '高雄', '07-7777-771', '客戶一')

------------------******************************************-------------

CREATE TRIGGER 處理新增客戶
ON 文字處理
INSTEAD OF INSERT
AS
SET NOCOUNT ON

-- 必要時新增客戶資料, --沒有客戶資料時新增客戶
INSERT 文字處理 (客戶編號, 客戶地址, 客戶電話, 客戶名稱)
SELECT *
FROM inserted
WHERE  inserted.客戶編號 NOT IN ( SELECT 客戶編號 FROM 文字處理  )
/*
-- 新增客戶資料
IF @@ROWCOUNT = 0   -- 如果沒有新增客戶
    INSERT 訂單T6 (日期, 客戶編號, 數量, 是否付款)
    SELECT 日期, 客戶編號, 數量, 是否付款
    FROM inserted
ELSE                                   -- 否則以新的客戶編號來更新訂單
    INSERT 訂單T6 (日期, 客戶編號, 數量, 是否付款)
    SELECT 日期, 客戶T6.客戶編號, 數量, 是否付款
    FROM inserted JOIN 客戶T6 ON inserted.客戶名稱 =客戶T6.客戶名稱
GO
*/
   -- 先匯入
	INSERT 文字處理 (客戶編號, 客戶地址, 客戶電話, 客戶名稱)
	SELECT 文字處理.客戶編號,客戶地址, 客戶電話, 客戶名稱
	FROM inserted join 文字處理 on inserted.客戶地址 = 文字處理.客戶地址

    -- 修改再匯入
	INSERT  文字處理
	select 客戶編號 = LEFT( inserted.客戶編號,2) + cast (cast(RIGHT( inserted.客戶編號,4)as int )+1  as varchar), 客戶地址, 客戶電話, 客戶名稱   
				
    FROM inserted 
    --WHERE  inserted.客戶地址 = 文字處理.客戶地址
GO

--------------------***************************--------------------------
--正常
 INSERT 文字處理 (客戶編號, 客戶地址, 客戶電話, 客戶名稱)
 VALUES ('999999', '台中', '04-4444-442', '客戶二')
 INSERT 文字處理 (客戶編號, 客戶地址, 客戶電話, 客戶名稱)
 VALUES ('999999', '台北', '02-2222-222', '客戶二')
 INSERT 文字處理 (客戶編號, 客戶地址, 客戶電話, 客戶名稱)
 VALUES ('999999', '高雄', '07-7777-772', '客戶二')
 --顛倒順序
 INSERT 文字處理 (客戶編號, 客戶地址, 客戶電話, 客戶名稱)
 VALUES ('999999', '台北', '02-2222-224', '客戶四')
 INSERT 文字處理 (客戶編號, 客戶地址, 客戶電話, 客戶名稱)
 VALUES ('999999', '台北', '02-2222-223', '客戶三')
 --重複
 INSERT 文字處理 (客戶編號, 客戶地址, 客戶電話, 客戶名稱)
 VALUES ('999999', '高雄', '07-7777-771', '客戶一') 
 INSERT 文字處理 (客戶編號, 客戶地址, 客戶電話, 客戶名稱)
 VALUES ('999999', '高雄', '07-7777-772', '客戶二')

GO
---------------*********************************-----------------
SELECT * FROM 文字處理

GO 
------------***************************************-------------



