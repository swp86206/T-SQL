SELECT *
INTO #客戶1 -- INTO 為建立資料表
FROM 客戶

SELECT * FROM #客戶1 --#客戶1, #為區域暫存資料表,連線斷了就不能看

SELECT *
INTO ##客戶2 -- INTO 為建立資料表
FROM 客戶

SELECT * FROM ##客戶2  -- ##客戶2,為全域暫存資料表,全部連線中斷,SQL關掉重開才會不見

SELECT *
INTO 客戶3 -- INTO 為建立資料表,有# 為暫存資料表,沒有#為建立資料表
FROM 客戶
