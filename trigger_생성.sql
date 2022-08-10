drop database if exists triggerDB;
create database if not exists triggerDB;

use triggerdb;
create table orderTbl(
	orderNo int auto_increment primary key,
    userId varchar(5),
    prodname varchar(5),
    orderamount int
);
create table prodTbl(
	prodName varchar(5),
    account int
);
create table deliverTbl(
	deliverNo int auto_increment primary key,
    prodName varchar(5),
    account int
);
insert into prodTbl values('사과', 100);
insert into prodTbl values('배', 100);
insert into prodTbl values('귤', 100);

drop trigger if exists orderTrg;
delimiter //
create trigger orderTrg
	after insert
    on orderTbl
    for each row
begin
	update prodTbl set account = account - New.orderamount
		where prodName = new.prodName;
end //
delimiter ;

drop trigger if exists prodTrg;
delimiter //
create trigger prodTrg
	after update
    on prodTbl
    for each row
begin
	declare orderamount int;
    set orderAmount = old.account - new.account ;
    insert into deliverTbl(prodName, account)
		values(new.prodName, orderAmount);
end //
delimiter ;

insert into orderTbl values (null, 'JOHN', '배', 5);

select * from orderTbl;
select * from prodTbl;
select * from deliverTbl;

alter table deliverTbl change prodName productName varchar(5);

insert into orderTbl values (null, 'Dang', '사과', 9);

select * from orderTbl;
select * from prodTbl;
select * from deliverTbl;