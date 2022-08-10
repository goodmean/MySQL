create database if not exists testDB;
use testDB;
create table if not exists testTbl(
	id int, txt varchar(10));
insert into testTbl values(1, '레드벨벳');
insert into testTbl values(2, '잇지');
insert into testTbl values(3, '블랙핑크');

drop trigger if exists testTrg;
delimiter $$
create trigger testTrg -- 트리거 이름
	after delete -- 삭제 후에 작동
    on testTbl -- 트리거를 부착할 테이블
    for each row -- 각 행마다 적용시킴
begin
	set @msg = '가수 그룹이 삭제됨' ; -- 트리거 실행 시 작동되는 코드
end $$
delimiter ;

set @msg = '';
insert into testTbl values(4, '마마무');
select @msg;
update testTbl set txt = '블핑' where id = 3;
select @msg;
delete from testTbl where id = 4;
select @msg;

USE sqldb;
drop table buyTbl;
CREATE TABLE backup_usertbl -- 변경되기 전의 데이터를 저장할 테이블을 하나 생성
( userID  	CHAR(8) NOT NULL PRIMARY KEY,
  name    	VARCHAR(10) NOT NULL,
  birthYear INT NOT NULL,
  addr	  	CHAR(2) NOT NULL,
  mobile1	CHAR(3),
  mobile2	CHAR(8),
  height    SMALLINT,
  mDate    	DATE,
  modType   char(2), -- 변경된 타입. '수정' 또는 '삭제'
  modDate   date, -- 변경된 날짜
  modUser   varchar(256) -- 변경한 사용자
);

drop trigger if exists backUserTbl_UpdateTrg;
delimiter //
create trigger backUserTbl_UpdateTrg
	after update
	on userTbl
    for each row
begin
	insert into backup_userTbl values( 
		old.userId, old.name, old.birthYear, old.addr, old.mobile1, old.mobile2, old.height, old.mDate,
        '수정', curdate(), current_user() );
end //
delimiter ;

drop trigger if exists backUserTbl_DeleteTrg;
delimiter //
create trigger backUserTbl_DeleteTrg
	after delete
    on userTbl
    for each row
begin
	insert into backup_userTbl values(
		old.userId, old.name, old.birthYear, old.addr, old.mobile1, old.mobile2, old.height, old.mDate,
        '삭제', curdate(), current_user() );
end //
delimiter ;

update userTbl set addr = '몽고' where userId = 'JKW';
delete from userTbl where height >= 177;

select * from backup_userTbl;

truncate table userTbl;
select * from backup_userTbl;

drop trigger if exists userTbl_InsertTrg;
delimiter //
create trigger userTbl_insertTrg
	after insert
    on userTbl
    for each row
begin
	signal sqlstate '45000'
		set message_text = '데이터의 입력을 시도했습니다. 귀하의 정보가 서버에 기록되었습니다.';
end //
delimiter ;

insert into userTbl values('ABC', '에비씨', 1977, '서울', '011', '1111111', 181, '2019-12-25');

use sqldb;
drop trigger if exists userTbl_BeforeInsertTrg;
delimiter //
create trigger userTbl_BeforeInsertTrg
	before insert
    on userTbl
    for each row
begin
	if new.birthYear < 1900 then
		set new.birthYear = 0;
	elseif new.birthYear > Year(curdate()) then
		set new.birthYear = Year(curdate());
	end if;
end //
delimiter ;

insert into userTbl values
	('aaa', '에이', 1877, '서울', '011', '1112222', 181, '2022-12-25');
insert into userTbl values
	('bbb', '비이', 2977, '경기', '011', '1113333', 171, '2019-3-25');
    
select * from userTbl;

show triggers from sqlDb;
drop trigger userTbl_BeforeInsertTrg;