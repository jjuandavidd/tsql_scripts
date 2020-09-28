/* link back to original source and author:
    https://www.sqlservercentral.com/forums/topic/size-of-table-2
    https://www.sqlservercentral.com/forums/user/jeff-moden   */

USE (dbname) --replace me here

SELECT  SchemaName = OBJECT_SCHEMA_NAME(object_id)
        ,ObjectName = OBJECT_NAME(object_id)
        ,SizeMB     = SUM(reserved_page_count /128.0) --There are 128 pages per MB.
        --several more columns depending on what you need; play around and take a look
   FROM sys.dm_db_partition_stats
  WHERE object_id = OBJECT_ID('SomeSchemaName.SomeObjectNameHere')  --Schema name and object name here
    AND index_id IN (0,1) --Heap or Clustered Index, which is where the data lives (comment out to include all indexes).
  GROUP BY object_id
;
