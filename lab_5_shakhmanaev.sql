USE master;
GO

IF DB_ID(N'LAB5_DB') IS NOT NULL
DROP DATABASE LAB5_DB;
GO

CREATE DATABASE LAB5_DB
ON PRIMARY
( NAME = MyDB_PrimaryData,
FILENAME = '/home/kurilab/projects/db_labs/LAB5_DB/mydb.mdf' )
LOG ON
( NAME = LogOne, FILENAME = '/home/kurilab/projects/db_labs/LAB5_DB/mylog.ldf',
    SIZE = 5MB, MAXSIZE = 25MB, FILEGROWTH = 5MB)
GO

ALTER DATABASE LAB5_DB
ADD FILE ( NAME = MyDB_SecondaryData,
FILENAME = '/home/kurilab/projects/db_labs/LAB5_DB/mydb1.ndf')
GO

ALTER DATABASE LAB5_DB
ADD FILEGROUP LargeFileGroup
GO

ALTER DATABASE LAB5_DB
ADD FILE ( NAME = MyDB_LargeData,
FILENAME = '/home/kurilab/projects/db_labs/LAB5_DB/mydb2.ndf')
TO FILEGROUP LargeFileGroup
GO

ALTER DATABASE LAB5_DB
MODIFY FILEGROUP LargeFileGroup DEFAULT;
GO

USE LAB5_DB
GO


CREATE TABLE LAB5_DB..Users (
    id int,
    age int,
    email varchar(255)
)
GO

ALTER DATABASE LAB5_DB
MODIFY FILEGROUP [Primary] DEFAULT;
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Products')
    CREATE TABLE Products(
        id int,
        name varchar(30),
        price int
    )
GO


ALTER DATABASE LAB5_DB
REMOVE FILE MyDB_LargeData
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Users1')
    DROP TABLE Users1
GO

SELECT * INTO dbo.Users1 FROM Users
GO

DROP TABLE Users
GO

ALTER DATABASE LAB5_DB
REMOVE FILEGROUP LargeFileGroup;
GO

USE LAB5_DB
GO

CREATE SCHEMA MySchema;
GO

ALTER SCHEMA MySchema
    TRANSFER dbo.Users1;
GO

DROP Table MySchema.Users1;
GO

DROP SCHEMA MySchema;
GO

