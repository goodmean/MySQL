use sqldb;
drop function if exists getAgeFunc;
delimiter $$
create function getAgeFunc(bYear int)
	returns int
begin
	declare age int;
    set age = year(curdate()) - bYear;
    return age;
end $$
delimiter ;

select getAgeFunc(1979);

select getAgeFunc(1979) into @age1979;
select getAgeFunc(1997) into @age1989;
select concat('1997년과 1979년의 나이차 ==> ', (@age1979 - @age1989));

select userID, name, getAgeFunc(birthYear) as '만 나이' from userTbl;

show create function getAgeFunc;

drop function getAgeFunc;