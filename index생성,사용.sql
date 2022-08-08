use sqldb;
select * from usertbl;

show index from usertbl;

show table status like 'usertbl';

create index idx_usertbl_addr
	on usertbl (addr);

show index from usertbl;
show table status like 'usertbl';

analyze table usertbl;
show table status like 'usertbl';

create unique index idx_usertbl_birthYear
	on usertbl (birthYear); -- 출생년도에 1979가 중복된 값이 있어서 오류
    
create unique index idx_usertbl_name
	on usertbl (name);
show index from usertbl;

insert into usertbl values('GPS', '김범수', 1983, '미국', null, null, 162, null); -- 김범수가 중복되어 오류

create index idx_usertbl_name_birthYear
	on usertbl (name, birthYear);
drop index idx_usertbl_name on usertbl;

show index from usertbl;

select * from usertbl where name = '윤종신' and birthYear = '1969';

select * from usertbl where name = '윤종신';

create index idx_usertbl_mobile1
	on usertbl (mobile1); -- 선택도가 나쁜 데이터, index를 생성하지 않는 편이 낫다.

select * from usertbl where mobile1 = '011';

show index from usertbl;

drop index idx_usertbl_addr on usertbl;
drop index idx_usertbl_name_birthYear on usertbl;
drop index idx_usertbl_mobile1 on usertbl;

alter table usertbl drop primary key;

select table_name, constraint_name
	from information_schema.referential_constraints
    where constraint_schema = 'sqldb';

alter table buyTbl drop foreign key buytbl_ibfk_1;
alter table usertbl drop primary key;

