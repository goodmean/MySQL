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

USE sqldb;
create view v_usertbl
as
	select userid, name, addr from usertbl;
    
select * from v_usertbl;

select U.userid, U.name, B.prodName, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
from usertbl U
	join buytbl B
		on U.userid = B.userid;
        
create view v_userbuytbl
as
	select U.userid, U.name, B.prodName, U.addr, Concat(U.mobile1, U.mobile2) as '연락처'
    from usertbl U
		join buytbl B
			on U.userid = B.userid;
            
select * from v_userbuytbl where name = '김범수';

use sqldb;
drop view if exists v_userbuytbl;
create view v_userbuytbl
as
	select U.userid as 'USER ID', U.name as 'USER NAME', B.prodName as 'PRODUCT NAME', U.addr, concat(U.mobile1, U.mobile2) as 'MOBILE PHONE'
	from usertbl U
		join buytbl B
			on U.userid = B.userid;
            
select `user id`, `user name` from v_userbuytbl;

use sqldb;
create or replace view v_usertbl
as
	select userid, name, addr from usertbl;
    
desc v_usertbl;
desc usertbl; -- 이건 describe 정렬은 descend

show create view v_usertbl;

update v_usertbl set addr = '부산' where userid='JKW';

insert into v_usertbl(userid, name, addr) values('KBM', '김병만', '충북');

create view v_sum
as
	select userid as 'userid', sum(price*amount) as 'total'
		from buytbl group by userid;
	
select * from v_sum;

select * from information_schema.views
	where table_schema = 'sqldb' and table_name = 'v_sum';
    
create view v_height177
as
	select * from usertbl where height >= 177;
    
select * from v_height177;

delete from v_height177 where height < 177;

insert into v_height177 values('KBM', '김병만', 1977, '경기', '010', '5555555', 158, '2023-01-01');

ALTER view v_height177
as
	select * from usertbl where height >= 177
		with check option;
        
insert into v_height177 values('SJH', '서장훈', 2006, '서울', '010', '3333333', 155, '2023-03-03');

DROP TABLE IF EXISTS BUYTBL, USERTBL;
SELECT * FROM V_USERBUYTBL;

CHECK TABLE V_USERBUYTBL;




