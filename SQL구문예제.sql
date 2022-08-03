DROP DATABASE IF EXISTS sqldb; -- 만약 sqldb가 존재하면 우선 삭제한다.
CREATE DATABASE sqldb;

USE sqldb;
CREATE TABLE usertbl -- 회원 테이블
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name    	VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr	  	CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 키
  mDate    	DATE  -- 회원 가입일
);
CREATE TABLE buytbl -- 회원 구매 테이블(Buy Table의 약자)
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	CHAR(6) NOT NULL, --  물품명
   groupName 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 단가
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES usertbl(userID)
);

INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

SELECT * FROM usertbl;
SELECT * FROM buytbl;

-- 데이터 입력 끝

SELECT * FROM usertbl WHERE name = '김경호';

SELECT userID, Name FROM usertbl WHERE birthYear >= 1970 AND height >= 182;
SELECT userID, Name FROM usertbl WHERE birthYear >= 1970 OR height >= 182;

SELECT name, height FROM usertbl WHERE height >= 180 AND height <= 183;
SELECT name, height FROM usertbl WHERE height BETWEEN 180 AND 183; -- 위 and 구문과 같은 뜻

SELECT name, addr FROM usertbl WHERE addr='경남' OR addr='전남' OR addr='경북';
SELECT name, addr FROM usertbl WHERE addr IN ('경남', '전남', '경북'); -- 위 or 구문과 같은 뜻
SELECT name, height FROM usertbl WHERE name LIKE '김%'; -- 성이 김씨이고 그 뒤는 무엇이든 허용
SELECT name, height FROM usertbl WHERE name LIKE '_종신'; -- 맨앞 한글자 다음이 종신인 사람을 조회

SELECT name, height FROM usertbl WHERE height > 177;
SELECT name, height FROM usertbl
	WHERE height > (SELECT height FROM usertbl WHERE name = '김경호'); -- 서브쿼리, 김경호씨의 키를 직접 입력
SELECT name, height FROM usertbl
	WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남'); -- 하위쿼리가 둘 이상의 값을 반환할 때 any는 제일 낮은거보다만 높으면 됨
    SELECT name, height FROM usertbl
	WHERE height >= ALL (SELECT height FROM usertbl WHERE addr = '경남'); -- 하위쿼리가 둘 이상의 값을 반환할 때 all은 제일 높은것보다 높아야 함
SELECT name, height FROM usertbl
	WHERE height = ANY (SELECT height FROM usertbl WHERE addr = '경남');
    
SELECT name, mDate FROM usertbl ORDER BY mDate; -- 오름차순 정렬 ASC가 생략되어있음
SELECT name, mDate FROM usertbl ORDER BY mDate DESC; -- 내림차순 정렬
SELECT name, height FROM usertbl ORDER BY height DESC, name ASC; -- 키가 큰 순서대로 정렬하되, 키가 같으면 이름 순으로 정렬한다.

SELECT addr FROM usertbl;
SELECT DISTINCT addr FROM usertbl; -- 중복된것은 하나만 남김

USE employees;
SELECT emp_no, hire_date FROM employees
	ORDER BY hire_date;
SELECT emp_no, hire_date FROM employees
	ORDER BY hire_date
    LIMIT 5; -- 상위의 5개만 출력
SELECT emp_no, hire_date FROM employees
	ORDER BY hire_date
    LIMIT 0,5; -- 0번째 부터 5개만 출력
    
USE sqldb;
CREATE TABLE buytbl2 (SELECT * FROM buytbl); -- buytbl1을 buytbl2로 복사
SELECT * FROM buytbl2;
CREATE TABLE buytbl3 (SELECT userId, prodName FROM buytbl); -- 필요한 항목만 복사 가능
SELECT * FROM buytbl3;

USE sqldb;
SELECT userID, amount FROM buytbl ORDER BY userID;
SELECT userID, SUM(amount) FROM buytbl GROUP BY userID; -- 총합
SELECT userID '사용자 아이디', SUM(amount) '총 구매 개수'
	FROM buytbl GROUP BY userID;
SELECT userID '사용자 아이디', SUM(price*amount) '총 구매액'
	FROM buytbl GROUP BY userID;
    
use sqldb;
select avg(amount) '평균 구매 개수' from buytbl; -- 평균
select userID, avg(amount) '평균 구매 개수' from buytbl group by userID;
select name, height from usertbl
	where height = (select max(height) from usertbl)
			or height = (select min(height) from usertbl); -- 가장 큰키와 가장 작은키의 회원이름과 키를 출력
select count(*) from usertbl;
select count(mobile1) '휴대폰이 있는 사용자' from usertbl; -- 카운트

SELECT userID '사용자 아이디', SUM(price*amount) '총 구매액'
	FROM buytbl GROUP BY userID;
SELECT userID '사용자 아이디', SUM(price*amount) '총 구매액'
	FROM buytbl GROUP BY userID
    having sum(price*amount) >= 1000 -- 집계 함수를 쓰는 조건절은 HAVING 사용, GROUP BY 다음으로 위치
    order by sum(price*amount);