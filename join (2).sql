SE market_db;

SELECT * FROM buy -- 첫 번째 테이블
	INNER JOIN members -- 두 번째 테이블
		ON buy.mem_id = members.mem_id -- 조인될 조건 : mem_id 가 같은 항목
	WHERE buy.mem_id = 'GRL'; -- mem__id 가 'GRL'인 행만 표시
    
SELECT * FROM buy
	JOIN members
		ON buy.mem_id = members.mem_id
	ORDER BY num;
    
select buy.mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) '연락처'
from buy
	join members
		on buy.mem_id = members.mem_id;
        
select B.mem_id, M.mem_name, B.prod_name, M.addr, CONCAT(M.phone1, M.phone2) '연락처'
from buy B -- 여기서 테이블 이름에 별칭을 붙임
	join members M -- 여기서 테이블 이름에 별칭을 붙임
		on B.mem_id = M.mem_id;
    
SELECT * FROM buy;
SELECT * FROM members;