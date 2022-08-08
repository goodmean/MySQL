use market_db;
select * from members;
show index from members;
show table status like 'members';

create index idx_member_addr
	on members (addr);
    
analyze table members;

create unique index idx_member_mem_name
	on members (mem_name);
    
select mem_id, mem_name, addr from members;

select mem_id, mem_name, addr from members where mem_name = '에이핑크';

create index idx_member_mem_number
	on members (mem_number);
analyze table members;

select mem_name, mem_number
	from members
	where mem_number >= 7;
    
select mem_name, mem_number
	from members
	where mem_number >= 1;
    
select mem_name, mem_number
	from members
	where mem_number*2 >= 14;
    
select mem_name, mem_number
	from members
	where mem_number >= 14/2;
    
show index from members;

drop index idx_member_mem_name on members;
drop index idx_member_addr on members;
drop index idx_member_mem_number on members;

select table_name, constraint_name
	from information_schema.referential_constraints
    where constraint_schema = 'market_db';
    
alter table members
	drop primary key;