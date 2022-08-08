USE sqldb;
DROP TABLE IF EXISTS members;
CREATE TABLE members(
	mem_id CHAR(8),
    mem_name VARCHAR(10),
    mem_number INT,
    addr CHAR(2)
);
INSERT INTO members VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO members VALUES('BLK', '블랙핑크', 4, '경남');
INSERT INTO members VALUES('WMN', '여자친구', 6, '경기');
INSERT INTO members VALUES('OMY', '오마이걸', 7, '서울');
SELECT * FROM members;

ALTER TABLE members
	ADD CONSTRAINT
    UNIQUE (mem_id);
    
SELECT * FROM members;

ALTER TABLE members
	ADD CONSTRAINT
    PRIMARY KEY (mem_name);
    
INSERT INTO members VALUES('GRL', '소녀시대', 8, '서울');
SELECT * FROM members;

