USE sqlDB;
DROP PROCEDURE IF EXISTS userProc1;

delimiter $$
CREATE PROCEDURE userProc1(IN userName VARCHAR(10))
BEGIN
	SELECT * FROM userTbl WHERE name = userName;
END $$
delimiter ;

CALL userProc1('조관우');

DROP PROCEDURE IF EXISTS userProc2;

delimiter $$
CREATE PROCEDURE userProc2(
	IN userBirth INT,
    IN userHeight INT
)
BEGIN
	SELECT * FROM userTbl
		WHERE birthYear > userBirth AND height > userHeight;
END $$
delimiter ;

CALL userProc2(1970, 178);

DROP PROCEDURE IF EXISTS userProc3;
delimiter $$
CREATE PROCEDURE userProc3(
	IN txtValue CHAR(10),
    OUT outValue INT
)
BEGIN
	INSERT INTO testTbl VALUES(NULL, txtValue);
    SELECT MAX(id) INTO outValue FROM testTbl;
END $$
delimiter ;

CREATE TABLE IF NOT EXISTS testTbl(
	id INT AUTO_INCREMENT PRIMARY KEY,
    txt CHAR(10)
);

CALL userProc3('테스트값',@myValue);
SELECT CONCAT('현재 입력된 ID값 ==>', @myValue);

DROP PROCEDURE IF EXISTS ifelseProc;
delimiter $$
CREATE PROCEDURE ifelseProc(
	IN userName VARCHAR(10)
)
BEGIN
	DECLARE bYear INT;
    SELECT birthYear INTO bYear FROM userTbl
		WHERE name = userName;
	IF(bYear >= 1980) THEN
		SELECT '아직 젊군요..';
	ELSE
		SELECT '나이가 지긋하시네요.';
	END IF;
END $$
delimiter ;

CALL ifelseProc('조용필');

DROP PROCEDURE IF EXISTS caseProc;
delimiter $$
CREATE PROCEDURE caseProc(
	IN userName VARCHAR(10)
)
BEGIN
	DECLARE bYear INT;
    DECLARE tti CHAR(3);
    SELECT birthYear INTO bYear FROM userTbl
		WHERE name = userName;
	CASE
		WHEN (bYear%12 = 0) THEN SET tti = '원숭이';
        WHEN (bYear%12 = 1) THEN SET tti = '닭';
        WHEN (bYear%12 = 2) THEN SET tti = '개';
        WHEN (bYear%12 = 3) THEN SET tti = '돼지';
        WHEN (bYear%12 = 4) THEN SET tti = '쥐';
        WHEN (bYear%12 = 5) THEN SET tti = '소';
        WHEN (bYear%12 = 6) THEN SET tti = '호랑이';
        WHEN (bYear%12 = 7) THEN SET tti = '토끼';
        WHEN (bYear%12 = 8) THEN SET tti = '용';
        WHEN (bYear%12 = 9) THEN SET tti = '뱀';
        WHEN (bYear%12 = 10) THEN SET tti = '말';
        WHEN (bYear%12 = 11) THEN SET tti = '양';
	END CASE;
    SELECT CONCAT(userName, '의 띠 ==>', tti);
END $$
delimiter ;

CALL caseProc ('김범수');

DROP TABLE IF EXISTS guguTbl;
CREATE TABLE guguTbl (txt VARCHAR(100));

DROP PROCEDURE IF EXISTS whileProc;
delimiter $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE str VARCHAR(100);
    DECLARE i INT;
    DECLARE k INT;
    SET i = 2;
    
    WHILE (i < 10) DO
		SET str = '';
        SET k = 1;
        WHILE (k < 10) DO
			SET str = CONCAT(i, 'x', k, '=', i*k, ' ');
            SET k = k + 1;
		END WHILE;
		SET i = i + 1;
        INSERT INTO guguTbl VALUES(str);
	END WHILE;
END $$
delimiter ;

CALL whileProc();
SELECT * FROM guguTbl;

DROP PROCEDURE IF EXISTS errorProc;
delimiter $$
CREATE PROCEDURE errorProc()
BEGIN
	DECLARE i INT;
    DECLARE hap INT;
    DECLARE saveHap INT;
    
    DECLARE EXIT HANDLER FOR 1264
    BEGIN
		SELECT CONCAT('int 오버플로 직전의 합계 -->', saveHap);
        SELECT CONCAT('1+2+3+4+...+', i, '=오버플로');
	END;
    
    SET i = 1;
    SET hap = 0;
    
    WHILE (1) DO
		SET saveHap = hap;
        SET hap = hap + i;
        SET i = i + 1;
	END WHILE;
END $$
delimiter ;

CALL errorProc();

SELECT routine_name, routine_definition FROM information_schema.routines
	WHERE routine_schema = 'sqldb' AND routine_type = 'procedure';
    
SELECT routine_name, routine_definition FROM information_schema.routines
	WHERE routine_schema = 'sqldb' AND routine_type = 'PROCEDURE';
    
SELECT parameter_mode, parameter_name, dtd_identifier
	FROM information_schema.parameters
    WHERE specific_name = 'userProc3';
    
SHOW CREATE PROCEDURE sqldb.userProc3;

DROP PROCEDURE IF EXISTS nameProc;
delimiter $$
CREATE PROCEDURE nameProc(
	IN tblName VARCHAR(20)
)
BEGIN
	SELECT * FROM tblName;
END $$
delimiter ;

CALL nameProc('userTbl');

DROP PROCEDURE IF EXISTS nameProc;
delimiter $$
CREATE PROCEDURE nameProc(
 IN tblName VARCHAR(20)
)
BEGIN
	SET @sqlQuery = CONCAT('select * from ', tblName);
    PREPARE myQuery FROM @sqlQuery;
    EXECUTE myQuery;
    DEALLOCATE PREPARE myQuery;
END $$
delimiter ;

CALL nameProc('userTbl');

delimiter $$
CREATE PROCEDURE delivProc(IN id VARCHAR(10))
BEGIN
	SELECT userId, name, addr, mobile1, mobile2
		FROM userTbl
        WHERE userId = id;
END $$
delimiter ;

CALL delivProc ('LJB');