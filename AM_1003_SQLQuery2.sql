CREATE table 客戶
(
編號	INT PRIMARY KEY, --設定為主鍵
姓名	NVARCHAR(50) NOT NULL,
性別	NCHAR(2) DEFAULT '未知', --客戶想要不詳,故設2 ;字串用單引號
年齡	INT DEFAULT 25 CHECK (年齡<150),  --CHECK是條件約束,超過範圍則出錯
電話	CHAR(14), --預設是NULL,可不填		
地址	NVARCHAR(50),
CHECK (電話 IS NOT NULL OR 地址 IS NOT NULL)  --放最後面作為資料表的檢查,判斷是不是空白
)