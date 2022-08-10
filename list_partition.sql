CREATE DATABASE IF NOT EXISTS partDB;
USE partDB;
DROP TABLE IF EXISTS partTbl;
CREATE TABLE partTbl(
	userId CHAR(8) NOT NULL,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL
)
PARTITION BY LIST COLUMNS(addr)(
	PARTITION part1 VALUES IN ('서울', '경기'),
    PARTITION part2 VALUES IN ('충북', '충남'),
    PARTITION part3 VALUES IN ('경북', '경남'),
    PARTITION part4 VALUES IN ('전북', '전남'),
    PARTITION part5 VALUES IN ('강원', '제주')
);
INSERT INTO partTbl
	SELECT userId, name, birthYear, addr FROM sqlDB.userTbl;
    
SELECT table_schema, table_name, partition_name, partition_ordinal_position, table_rows
	FROM information_schema.partitions
    WHERE table_name = 'parttbl';
    
SELECT * FROM partTbl;