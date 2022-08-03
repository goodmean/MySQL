DROP DATABASE IF EXISTS market_db; -- 만약 market_db가 존재하면 우선 삭제한다.
CREATE DATABASE market_db;

USE market_db; 
CREATE TABLE memberS -- 회원 테이블
( mem_id  		CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  mem_name    	VARCHAR(10) NOT NULL, -- 이름
  mem_number    INT NOT NULL,  -- 인원수
  addr	  		CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  phone1		CHAR(3), -- 연락처의 국번(02, 031, 055 등)
  phone2		CHAR(8), -- 연락처의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 평균 키
  debut_date	DATE  -- 데뷔 일자
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

SELECT * FROM members;
SELECT mem_name FROM members;
SELECT addr, debut_date, mem_name FROM members;
SELECT addr 주소, debut_date "데뷔 일자", mem_name "그룹 이름" FROM members;
SELECT * FROM members WHERE mem_name = '블랙핑크';
SELECT * FROM members WHERE mem_number = 4;
SELECT mem_id, mem_name FROM members WHERE height <= 162;
SELECT mem_name, height, mem_number FROM members WHERE height >= 165 AND mem_number > 6;
SELECT mem_name, height, mem_number FROM members WHERE height >= 165 OR mem_number > 6;
SELECT mem_name, height FROM members WHERE height >=163 AND height <= 165;
SELECT mem_name, height FROM members WHERE height BETWEEN 163 AND 165;
SELECT mem_name, addr FROM members WHERE addr = '경기' OR addr = '전남' OR addr = '경남';
SELECT mem_name, addr FROM members WHERE addr IN ('경기', '전남', '경남');	
SELECT * FROM members WHERE mem_name LIKE '우%';
SELECT * FROM members WHERE mem_name LIKE '__핑크';
SELECT height FROM members WHERE mem_name = '에이핑크';
SELECT mem_name, height FROM members WHERE height > 164;
SELECT mem_name, height FROM members
	WHERE height >= (SELECT height FROM members WHERE mem_name = '에이핑크');

SELECT mem_id, mem_name, debut_date FROM members ORDER BY debut_date;
SELECT mem_id, mem_name, debut_date, height FROM members WHERE height >= 164 ORDER BY height DESC;
SELECT mem_id, mem_name, debut_date, height FROM members WHERE height >= 164 ORDER BY height DESC, debut_date ASC;

USE market_db;
SET @myVar1 = 5;
SET @myVar2 = 4.25;

SELECT @myVar1;
SELECT @myVar1 + @myVar2 ;

SET @txt = '가수 이름==> ' ;
SET @height = 166;
SELECT @txt , mem_name FROM members WHERE height > @height ;

SELECT AVG(price) AS '평균 가격' FROM buy;

SELECT CAST(AVG(price) AS SIGNED) '평균 가격' FROM buy;
SELECT CONVERT(AVG(price) , SIGNED) '평균 가격' FROM buy;

select cast('2022$12$12' as date);
select cast('2022/12/12' as date);