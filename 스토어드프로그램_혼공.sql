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

DROP PROCEDURE IF EXISTS while_proc;
delimiter $$
CREATE PROCEDURE while_proc(
	IN start_num INT,
    IN end_num INT
)
BEGIN
	DECLARE hap INT;
    SET hap = 0;
    
    WHILE (start_num <= end_num) DO
		SET hap = hap + start_num;
        SET start_num = start_num + 1;
	END WHILE;
    SELECT hap;
END $$
delimiter ;

CALL while_proc(1, 100);

DROP PROCEDURE IF EXISTS dynamic_proc;
delimiter $$
CREATE PROCEDURE dynamic_proc(
	IN tableName VARCHAR(20)
)
BEGIN
	SET @sqlQuery = CONCAT('select * from ', tableName);
    PREPARE myQuery FROM @sqlQuery;
    EXECUTE myQuery;
    DEALLOCATE PREPARE myQuery;
END $$
delimiter ;

CALL dynamic_proc('members');

SET GLOBAL log_bin_trust_function_creators = 1;

USE market_db;
DROP FUNCTION IF EXISTS sumfunc;
delimiter $$
CREATE FUNCTION sumFunc(number1 INT, number2 INT)
	RETURNS INT
BEGIN
	RETURN number1 + number2;
END $$
delimiter ;

SELECT SUMFUNC(100, 200) AS '합계';

DROP FUNCTION IF EXISTS calcYearFunc;
delimiter $$
CREATE FUNCTION calcYearFunc(dYear INT)
	RETURNS INT
BEGIN
	DECLARE runYear INT;
    SET runYear = YEAR(CURDATE()) - dYear;
    RETURN runYear;
END $$
delimiter ;

SELECT CALCYEARFUNC(2010);

SELECT CALCYEARFUNC(2007) INTO @debut2007;
SELECT CALCYEARFUNC(2013) INTO @debut2013;
SELECT @debut2007 - @debut2013 AS '2007과 2013 차이';

SELECT mem_id, mem_name, CALCYEARFUNC(YEAR(debut_date)) AS '활동 햇수'
	FROM members;

USE market_db;
DROP PROCEDURE IF EXISTS cursorProc;
delimiter $$
CREATE PROCEDURE cursorProc()
BEGIN

	DECLARE memNumber INT;
	DECLARE cnt INT DEFAULT 0;
	DECLARE totNumber INT DEFAULT 0;
    DECLARE endOfRow BOOLEAN DEFAULT FALSE; -- 행의 끝 여부(기본을 FALSE)
    
    DECLARE userCursor CURSOR FOR -- 커서 선언
		SELECT mem_number FROM members;
        
	DECLARE CONTINUE HANDLER -- 행의 끝이면 endOfRow 변수에 true를 대입
		FOR NOT FOUND SET endOfRow = TRUE;
        
	OPEN userCursor;
    
    CURSOR_LOOP: LOOP
		FETCH userCursor INTO memNumber;
        
        IF endOfRow THEN
			LEAVE CURSOR_LOOP;
		END IF;
        
        SET cnt = cnt + 1;
        SET totNumber = totNumber + memNumber;
    END LOOP CURSOR_LOOP;
	
	SELECT (totNumber/cnt) AS '회원의 평균 인원 수';
    
    CLOSE userCursor;
END $$
delimiter ;

CALL cursorProc();