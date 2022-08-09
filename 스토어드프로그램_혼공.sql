USE market_db;
DROP PROCEDURE IF EXISTS user_proc;
delimiter $$
CREATE PROCEDURE user_proc()
BEGIN
	SELECT * FROM members;
END $$
delimiter ;

CALL user_proc();

DROP PROCEDURE IF EXISTS user_proc2;
delimiter $$
CREATE PROCEDURE user_proc2(IN userNumber INT, IN userHeight INT)
BEGIN
	SELECT * FROM members
		WHERE mem_number > userNumber AND height > userHeight;
END $$
delimiter ;

CALL user_proc2(6,165);

DROP PROCEDURE IF EXISTS user_proc3;
delimiter $$
CREATE PROCEDURE user_proc3(IN txtValue CHAR(10), OUT outValue INT)
BEGIN
	INSERT INTO noTable VALUES(NULL, txtValue);
    SELECT MAX(id) INTO outValue FROM noTable;
END $$
delimiter ;

CREATE TABLE IF NOT EXISTS noTable(id INT AUTO_INCREMENT PRIMARY KEY, txt CHAR(10));

CALL user_proc3 ('테스트1', @myValue);
SELECT CONCAT ('입력된 id 값 ==>', @myValue);

DROP PROCEDURE IF EXISTS ifeles_proc;
delimiter $$
CREATE PROCEDURE ifelse_proc(IN memName VARCHAR(10))
BEGIN
	DECLARE debutYear INT;
    SELECT YEAR(debut_date) INTO debutYear FROM members
		WHERE mem_name = memName;
	IF (debutYear >= 2015) THEN
		SELECT '신인 가수네요. 화이팅 하세요' AS '메시지';
	ELSE
		SELECT '고참 가수네요. 그동안 수고하셨어요.' AS '메시지';
	END IF;
END $$
delimiter ;

CALL ifelse_proc('오마이걸');

drop procedure if exists while_proc;
delimiter $$
create procedure while_proc(
	in start_num int,
    in end_num int
)
begin
	declare hap int;
    set hap = 0;
    
    while (start_num <= end_num) do
		set hap = hap + start_num;
        set start_num = start_num + 1;
	end while;
    select hap;
end $$
delimiter ;

call while_proc(1, 100);

drop procedure if exists dynamic_proc;
delimiter $$
create procedure dynamic_proc(
	in tableName varchar(20)
)
begin
	set @sqlQuery = concat('select * from ', tableName);
    prepare myQuery from @sqlQuery;
    execute myQuery;
    deallocate prepare myQuery;
end $$
delimiter ;

call dynamic_proc('members');

set global log_bin_trust_function_creators = 1;

use market_db;
drop function if exists sumfunc;
delimiter $$
create function sumFunc(number1 int, number2 int)
	returns int
begin
	return number1 + number2;
end $$
delimiter ;

select sumFunc(100, 200) as '합계';

drop function if exists calcYearFunc;
delimiter $$
create function calcYearFunc(dYear Int)
	returns int
begin
	declare runYear int;
    set runYear = Year(curdate()) - dYear;
    return runYear;
end $$
delimiter ;

select calcYearFunc(2010);

select calcYearFunc(2007) into @debut2007;
select calcYearFunc(2013) into @debut2013;
select @debut2007 - @debut2013 as '2007과 2013 차이';

select mem_id, mem_name, calcYearFunc(year(debut_date)) as '활동 햇수'
	from members;

use market_db;
drop procedure if exists cursorProc;
delimiter $$
create procedure cursorProc()
begin

	declare memNumber int;
	declare cnt int default 0;
	declare totNumber int default 0;
    declare endOfRow boolean default false; -- 행의 끝 여부(기본을 FALSE)
    
    declare userCursor Cursor for -- 커서 선언
		select mem_number from members;
        
	declare continue handler -- 행의 끝이면 endOfRow 변수에 true를 대입
		for not found set endOfRow = true;
        
	open userCursor;
    
    cursor_loop: loop
		fetch userCursor into memNumber;
        
        if endOfRow then
			leave cursor_loop;
		end if;
        
        set cnt = cnt + 1;
        set totNumber = totNumber + memNumber;
    end loop cursor_loop;
	
	select (totNumber/cnt) as '회원의 평균 인원 수';
    
    close userCursor;
end $$
delimiter ;

call cursorProc();