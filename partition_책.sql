create database if not exists partDB;
use partDB;
drop table if exists partTbl;
create table partTbl(
	userId char(8) not null,
    name varchar(10) not null,
    birthYear int not null,
    addr char(2) not null
)
partition by range(birthYear)(
	partition part1 values less than (1971),
    partition part2 values less than (1979),
    partition part3 values less than maxvalue
);
insert into partTbl
	select userId, name, birthYear, addr From sqlDB.userTbl;
    
select * from partTbl;

select table_schema, table_name, partition_name, partition_ordinal_position, table_rows
	from information_schema.partitions
    where table_name = 'parttbl'; -- 파티션 확인
    
explain select * from partTbl where birthYear <= 1965; -- 사용한 파티션 확인

alter table partTbl
	reorganize partition part3 into (
		partition part3 values less than (1986),
        partition part4 values less than maxvalue
    );
optimize table parttbl; -- 파티션 재구성

alter table partTbl
	reorganize partition part1, part2 into (
		partition part12 values less than (1979)
    );
optimize table partTbl;

alter table partTbl drop partition part12;
optimize table partTbl;

select * from partTbl;

create database if not exists partDB;
use partdb;
drop table if exists partTbl;