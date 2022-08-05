use market_db;
create view v_member
as
	select mem_Id, mem_name, addr from members;
    
select * from v_member;

select mem_name, addr from v_member
	where addr in ('서울', '경기');
    
create view v_memberbuy
as
	select B.mem_id, M.mem_name, B.prod_name, M.addr,
		concat(M.phone1, M.phone2) '연락처'
	from buy B
		join members M
			on B.mem_id = M.mem_id;
            
select * from v_memberbuy;

use market_db;
create view v_viewtest1
as
	select B.mem_id 'Member ID', M.mem_name as 'Member Name',
		B.prod_name "Product Name",
			concat(M.phone1, M.phone2) as "Office Phone"
		from buy B
			join members M
				on B.mem_id = M.mem_id;
                
select distinct `Member Id`, `Member Name` FROM v_viewtest1;

alter view v_viewtest1
as
	select B.mem_id '회원 아이디', M.mem_name '회원 이름',
		B.prod_name "제품 이름",
			concat(M.phone1, M.phone2) as "연락처"
		from buy B
			join members M
            on B.mem_id = M.mem_id;
select Distinct * from v_viewtest1;

drop view v_viewtest1;

create or replace view v_viewtest2
as
	select mem_id, mem_name, addr from members;
    
update v_member set addr = '부산' where mem_id = 'BLK';
select * from v_member;

create view v_height167
as
	select * from members where height >= 167;
select * from v_height167;





