DROP PROCEDURE IF EXISTS ifProc1;
DELIMITER $$
CREATE PROCEDURE ifProc()
BEGIN
	IF 100 = 100 THEN
		SELECT '100은 100과 같습니다.';
	END IF;
END $$
DELIMITER ;
CALL ifProc();
    
DROP PROCEDURE IF EXISTS ifProc2;
DELIMITER $$ -- 스토어드 프로시저 코딩 시작
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE myNum INT; -- var1 변수 선언
    SET myNum = 200; -- 변수에 값 대입
	IF myNum = 100 THEN -- 만약 @var1이 100이라면,
		SELECT '100입니다.';
	ELSE
		SELECT '100이 아닙니다.';
	END IF;
END $$ -- 스토어드 프로시저 코딩 끝
DELIMITER ; -- 종료문자
CALL ifProc2();

DROP PROCEDURE IF EXISTS ifProc3;
delimiter $$
CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE debutDate DATE;
    DECLARE curDate DATE;
    DECLARE days INT;
    
    SELECT debut_date INTO debutDate
		FROM market_db.members
        WHERE mem_id = 'APN';
        
	SET curDate = CURRENT_DATE();
    SET days = DATEDIFF(curDATE,debutDate);
    
    IF(days/365) >= 5 THEN
		SELECT CONCAT('데뷔한 지 ', days, '일이나 지났습니다. 핑순이들 축하합니다!');
	ELSE
		SELECT '데뷔한 지 ' + days + '일밖에 안되었네요. 핑순이들 화이팅~';
	END IF;
END $$
delimiter ;
CALL ifProc3();

select current_date(), datediff('2021-12-31', '2000-1-1');