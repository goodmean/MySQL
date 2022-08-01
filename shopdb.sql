use shotdb;

select * FROM `member`;

create table indexTBL (
	first_name varchar(14),
    last_name varchar(16),
    hire_date date
);
insert into indexTBL
	select first_name, last_name, hire_date
    from employees.employees
    limit 500;
select * from indexTBL;
select * from indexTBL where first_name = 'Mary';
create index idx_indexTBL_firstname on indexTBL(first_name);

create view member_view
as select member_name, member_addr from `member`;

select * from member_view;

delete from `member`;
