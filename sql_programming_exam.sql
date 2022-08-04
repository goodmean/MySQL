drop procedure if exists ifProc;
delimiter $$
create procedure ifProc()
begin
	declare var1 int;
    set var1 = 100;
    
    if var1 = 100 then
		select '100입니다';
	ELSE
		select '100이 아닙니다.';
	end if;
end $$
DELIMITER ;
CALL ifProc();

drop procedure if exists ifProc2;
use employees;

delimiter $$
create procedure ifProc2()
begin
	declare hireDate date;
    declare curDate date;
    declare days int;
    
    select hire_date into hireDate
		from employees.employees
        where emp_no = 10001;
        
	set curDate = current_date();
    set days = datediff(curDate, hireDate); -- 날짜의 차이, 일 단위
    
    if (days/365) >= 5 then
		select concat('입사한지 ', days, '일이나 지났습니다. 축하합니다!');
	else 
		select '입사한지 ' + days + '일밖에 안되었네요. 열심히 일하세요.' ;
	end if;
end $$
delimiter ;
call ifProc2();

drop procedure if exists ifProc3;
delimiter $$
create procedure ifProc3()
begin
	declare point int;
    declare credit char(1);
    set point = 77;
    
    if point >= 90 then
		set credit = 'A';
	elseif point >= 80 then
		set credit = 'B';
	elseif point >= 70 then
		set credit = 'C';
	elseif point >= 60 then
		set credit = 'D';
	else
		set credit = 'F';
	end if;
    select concat('취득점수==>', point), concat('학점==>', credit);
end $$
delimiter ;
call ifProc3();

drop procedure if exists caseProc;
delimiter $$
create procedure caseProc()
begin
	declare point int;
    declare credit char(1);
    set point = 77;
    
    case
		when point >= 90 then
			set credit = 'a';
		when point >= 80 then 
			set credit = 'b';
		when point >= 70 then
			set credit = 'c';
		when point >= 60 then
			set credit = 'd';
		else
			set credit = 'f';
	end case;
    select concat('취득점수==>', point), concat('학점==>', credit);
end $$;
delimiter ;
call caseProc();

drop procedure if exists gradeProc;
delimiter $$
create procedure gradeProc()
begin
	declare totalPrice int;
    declare grade char(5);
    
    select sum(price*amount) into totalPrice
		from sqldb.buytbl;
	
    case
		when totalPrice >= 1500 then
			set grade = '최우수고객';
		when totalPrice >= 1000 then
			set grade = '우수고객';
		when totalPrice >= 1 then
			set grade = '일반고객';
		else
			set grade = '유령고객';
	end case;
    select grade;
end $$
delimiter ;
call gradeProc();

select U.userID, name, sum(price*amount) '총구매액',
	case
		when sum(price*amount) >= 1500 then '최우수고객'
		when sum(price*amount) >= 1000 then '우수고객'
        when sum(price*amount) >= 1 then '일반고객'
        else '유령고객'
	end as '고객등급'
from buytbl B
	right join usertbl U
		on B.userID = U.userID
	group by U.userID
	order by sum(price*amount) desc;
	