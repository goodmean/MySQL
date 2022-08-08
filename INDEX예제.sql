USE sqldb;
CREATE TABLE tbl1(
	a INT PRIMARY KEY, -- 클러스터형 인덱스
    b INT,
    c INT
);
SHOW INDEX FROM tbl1;

CREATE TABLE tbl2(
	a INT PRIMARY KEY,
    b INT UNIQUE,
    c INT UNIQUE,
    d INT
);
SHOW INDEX FROM tbl2;

CREATE TABLE tbl3(
	a INT UNIQUE, -- 보조 인덱스, null 값 가능
    b INT UNIQUE,
    c INT UNIQUE,
    d INT
);
SHOW INDEX FROM tbl3;

CREATE TABLE tbl4(
	a INT UNIQUE NOT NULL, -- 클러스터형 인덱스가 됨
    b INT UNIQUE,
    c INT UNIQUE,
    d INT
);
SHOW INDEX FROM tbl4;

CREATE TABLE tbl5(
	a INT UNIQUE NOT NULL, -- primary key 와 unique not null이 있으면 primary key로 지정한 열에 우선 클러스터형 인덱스 생성.
    b INT UNIQUE,
    c INT UNIQUE,
    d INT PRIMARY KEY -- 클러스터형 인덱스
);
SHOW INDEX FROM tbl5;

CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl(
	userId CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL
);
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울');
SELECT * FROM usertbl;

ALTER TABLE usertbl DROP PRIMARY KEY;
ALTER TABLE usertbl
	ADD CONSTRAINT pk_name PRIMARY KEY(name);
SELECT * FROM usertbl;

CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
DROP TABLE IF EXISTS mixedtbl;
CREATE TABLE mixedtbl(
	userId CHAR(8) NOT NULL,
    name VARCHAR(10) NOT NULL,
    addr CHAR(2)
);
INSERT INTO mixedtbl VALUES('LSG', '이승기', '서울');
INSERT INTO mixedtbl VALUES('KBS', '김범수', '경남');
INSERT INTO mixedtbl VALUES('KKH', '김경호', '전남');
INSERT INTO mixedtbl VALUES('JYP', '조용필', '경기');
INSERT INTO mixedtbl VALUES('SSK', '성시경', '서울');
INSERT INTO mixedtbl VALUES('LJB', '임재범', '서울');
INSERT INTO mixedtbl VALUES('YJS', '윤종신', '경남');
INSERT INTO mixedtbl VALUES('EJW', '은지원', '경북');
INSERT INTO mixedtbl VALUES('JKW', '조관우', '경기');
INSERT INTO mixedtbl VALUES('BBK', '바비킴', '서울');
SELECT * FROM mixedtbl;

ALTER TABLE mixedtbl
	ADD CONSTRAINT pk_mikedtbl_userId
		PRIMARY KEY (userId);
        
ALTER TABLE mixedtbl
	ADD CONSTRAINT uk_mixedtbl_name
		UNIQUE (name);
        
SHOW INDEX FROM mixedtbl;