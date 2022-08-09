use market_db;
create table if not exists trigger_table (id int, txt varchar(10));
insert into trigger_table values(1, '레드벨벳');
insert into trigger_table values(2, '잇지');
insert into trigger_table values(3, '블랙핑크');
select * from trigger_table;

drop trigger if exists myTrigger;
delimiter $$
create trigger myTrigger
	after delete
    on trigger_table
    for each row
begin
	set @msg = '가수 그룹이 삭제됨' ;
end $$
delimiter ;

insert into trigger_table values(4, '마마무');
select @msg;
delete from trigger_table where id = 4;
select @msg;

use market_db;
create table singer(
	select mem_id, mem_name, mem_number, addr
		from members
);
select * from singer;

CREATE TABLE backup_singer (
    mem_id     CHAR(8) NOT NULL,
    mem_name   VARCHAR(10) NOT NULL,
    mem_number INT NOT NULL,
    addr       CHAR(2) NOT NULL,
    modType    CHAR(2),
    modDate    DATE,
    modUser    VARCHAR(30)
);

drop trigger if exists singer_updateTrg;
delimiter $$
create trigger singer_updateTrg
	after update
    on singer
    for each row
begin
	insert into backup_singer values(OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr, '수정', curdate(), current_user() );
end $$
delimiter ;

update singer set addr = '영국' where mem_id = 'BLK';
select*from backup_singer;