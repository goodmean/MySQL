USE tabledb;
DROP TABLE IF EXISTS buytbl, usertbl;
CREATE TABLE usertbl(
	userID    CHAR(8),
    name      VARCHAR(10),
    birthYear INT,
    addr      CHAR(2),
    mobile1   CHAR(3),
    mobile2   CHAR(8),
    height    SMALLINT,
    mDate     DATE
);
CREATE TABLE buytbl(
	num INT   AUTO_INCREMENT PRIMARY KEY,
    userid    CHAR(8),
    prodName  CHAR(6),
    proupName CHAR(4),
    price     INT,
    amount    SMALLINT
);

INSERT INTO usertbl VALUES
	('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES
	('KBS', '김범수', NULL, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES
	('KKH', '김경호', 1871, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES
	('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL ,   30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자',  200, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자',  200, 5);

ALTER TABLE usertbl
	ADD CONSTRAINT pk_usertbl_userid
    PRIMARY KEY (userid);

DESC usertbl;

ALTER TABLE buytbl
	ADD CONSTRAINT fk_usertbl_buytbl
    FOREIGN KEY (userID)
    REFERENCES usertbl (userID);
    
DELETE FROM buytbl WHERE userid = 'BBK';
ALTER TABLE buytbl
	ADD CONSTRAINT fk_usertbl_buytbl
    FOREIGN KEY (userId)
    REFERENCES usertbl (userID);
    
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200, 5);

SET foreign_key_checks = 0;
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50 ,  3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80 , 10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'   , '서적', 15 ,  5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'   , '서적', 15 ,  2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50 ,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL , 30 ,  2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'   , '서적', 15 ,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL , 30 ,  2);
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE usertbl
	ADD CONSTRAINT ck_birthyear
    CHECK ( (birthYear >= 1900 AND birthYear <= 2023) AND (birthYear IS NOT NULL) );
    
UPDATE usertbl SET birthYear = 1979 WHERE userId = 'KBS';
UPDATE usertbl SET birthYear = 1971 WHERE userId = 'KKH';

INSERT INTO usertbl VALUES('TKV', '태권뷔', 2999, '우주', NULL, NULL, 186, '2023-12-12');

INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL , NULL     , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9'  );
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL , NULL     , 170, '2005-5-5'  );
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3'  );
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5'  );

UPDATE usertbl SET userId = 'VVK' WHERE userId = 'BBK';

SET foreign_key_checks = 0;
UPDATE usertbl SET userId = 'VVK' WHERE userId = 'BBK';
SET foreign_key_checks = 1;

SELECT B.userid, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
	FROM buytbl B
		LEFT JOIN usertbl U
			ON B.userid = U.userid
	ORDER BY B.userid;
    
SET foreign_key_checks = 0;
UPDATE usertbl SET userId = 'BBK' WHERE userId = 'VVK';
SET foreign_key_checks = 1;
            
ALTER TABLE buytbl
	DROP FOREIGN KEY fk_usertbl_buytbl;
ALTER TABLE buytbl
	ADD CONSTRAINT fk_usertbl_buytbl
		FOREIGN KEY (userId)
        REFERENCES usertbl (userId)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
        
UPDATE usertbl SET userid = 'VVK' WHERE userid = 'BBK';
SELECT b.userid, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
	FROM buytbl B
		JOIN usertbl U
			ON B.userid = U.userid
	ORDER BY B.userid;

DELETE FROM usertbl WHERE userId = 'VVK';
SELECT * FROM buytbl;

ALTER TABLE usertbl
	DROP COLUMN birthYear;