sp_helpdb[教育部] --報告此資料庫相關資訊

alter database [教育部]
ADD FILE    /*修改用*/
(
NAME = 教育部F3 ,
FILENAME = 'C:\DB\edu_3.ndf'
)

DROP DATABASE --DROP是整個移除，檔案都不見

delete 訂閱記錄 --delete 是刪除記錄，檔案還在

-- 工作 --> 右鍵-卸離  // 檔案都還在,SQL看不到
-- 資料庫 --> 右鍵-附加 --> 加入,一路徑選取檔案  //把卸離的檔案再加回去

