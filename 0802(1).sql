DROP DATABASE IF EXISTS market_db; -- 만약 market_db가 존재하면 우선 삭제한다.
CREATE DATABASE market_db;

USE market_db;
CREATE TABLE members (
    mem_id CHAR(8) NOT NULL PRIMARY KEY,
    mem_name VARCHAR(10) NOT NULL,
    mem_number INT NOT NULL,
    addr CHAR(2) NOT NULL,
    phone1 CHAR(3),
    phone2 CHAR(8),
    height SMALLINT,
    debut_date DATE
);
CREATE TABLE buy (
    num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    mem_id CHAR(8) NOT NULL,
    prod_name CHAR(6) NOT NULL,
    group_name CHAR(4),
    price INT NOT NULL,
    amount SMALLINT NOT NULL,
    FOREIGN KEY (mem_id)
        REFERENCES members (mem_id)
);

INSERT INTO members VALUES('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015.10.19');
INSERT INTO members VALUES('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016.08.08');
INSERT INTO members VALUES('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015.01.15');
INSERT INTO members VALUES('OMY', '오마이걸', 7, '서울', NULL, NULL, 160, '2015.04.21');
INSERT INTO members VALUES('GRL', '소녀시대', 8, '서울', '02', '44444444', 168, '2007.08.02');
INSERT INTO members VALUES('ITZ', '잇지', 5, '경남', NULL, NULL, 167, '2019.02.12');
INSERT INTO members VALUES('RED', '레드벨벳', 4, '경북', '054', '55555555', 161, '2014.08.01');
INSERT INTO members VALUES('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011.02.10');
INSERT INTO members VALUES('SPC', '우주소녀', 13, '서울', '02', '88888888', 162, '2016.02.25');
INSERT INTO members VALUES('MMU', '마마무', 4, '전남', '061', '99999999', 165, '2014.06.19');

INSERT INTO buy VALUES(NULL, 'BLK', '지갑', NULL, 30, 2);
INSERT INTO buy VALUES(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES(NULL, 'APN', '아이폰', '디지털', 200, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '아이폰', '디지털', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', '청바지', '패션', 50, 3);
INSERT INTO buy VALUES(NULL, 'MMU', '에어팟', '디지털', 80, 10);
INSERT INTO buy VALUES(NULL, 'GRL', '혼공SQL', '서적', 15, 5);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 2);
INSERT INTO buy VALUES(NULL, 'APN', '청바지', '패션', 50, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 4);

SELECT * FROM members;
SELECT * FROM buy;

SELECT * FROM members LIMIT 3; -- 3개만 보여준다
SELECT DISTINCT addr FROM members; -- 중복 제거
SELECT mem_name, debut_date FROM members ORDER BY debut_date LIMIT 3;
SELECT mem_name, height FROM members ORDER BY height DESC LIMIT 3, 2;
SELECT mem_id, SUM(amount) FROM buy GROUP BY mem_id;
SELECT mem_id "회원 아이디", SUM(amount) "총 구매 개수"
	FROM buy GROUP BY mem_id;
SELECT mem_id "회원 아이디", SUM(price*amount) "총 구매 금액"
	FROM buy GROUP BY mem_id;
SELECT AVG(amount) "평균 구매 개수" FROM buy;
SELECT mem_id "회원 아이디", AVG(amount) "퍙균 구매 개수"
	FROM buy GROUP BY mem_id;
SELECT COUNT(*) FROM members;
SELECT COUNT(phone1) "연락처가 있는 회원" FROM members;
SELECT mem_id "회원 아이디", SUM(price*amount) "총 구매 금액"
	FROM buy GROUP BY mem_id;

SELECT mem_id "회원 아이디", SUM(price*amount) "총 구매 금액"
	FROM buy
    GROUP BY mem_id
    HAVING SUM(price*amount) > 1000;
    
SELECT mem_id "회원 아이디", SUM(price*amount) "총 구매 금액"
	FROM buy
    GROUP BY mem_id
    HAVING SUM(price*amount) > 1000
    ORDER BY SUM(price*amount) DESC;
    
