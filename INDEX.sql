USE market_db;
SELECT * FROM members;
SHOW INDEX FROM members;
SHOW TABLE STATUS LIKE 'members';

CREATE INDEX idx_member_addr
	ON members (addr);
    
ANALYZE TABLE members;

CREATE UNIQUE INDEX idx_member_mem_name
	ON members (mem_name);
    
SELECT mem_id, mem_name, addr FROM members;

SELECT mem_id, mem_name, addr FROM members WHERE mem_name = '에이핑크';

CREATE INDEX idx_member_mem_number
	ON members (mem_number);
ANALYZE TABLE members;

SELECT mem_name, mem_number
	FROM members
	WHERE mem_number >= 7;
    
SELECT mem_name, mem_number
	FROM members
	WHERE mem_number >= 1;
    
SELECT mem_name, mem_number
	FROM members
	WHERE mem_number*2 >= 14;
    
SELECT mem_name, mem_number
	FROM members
	WHERE mem_number >= 14/2;
    
SHOW INDEX FROM members;

DROP INDEX idx_member_mem_name ON members;
DROP INDEX idx_member_addr ON members;
DROP INDEX idx_member_mem_number ON members;

SELECT table_name, constraint_name
	FROM information_schema.referential_constraints
    WHERE constraint_schema = 'market_db';
    
ALTER TABLE members
	DROP PRIMARY KEY;