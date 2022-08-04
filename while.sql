DROP PROCEDURE IF EXISTS whileProc;
delimiter $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE i INT;
    DECLARE hap INT;
    DECLARE startNum INT;
    DECLARE endNum INT;
    
    SET startNum = 1; -- startNum 부터
    SET endNum = 100; -- endNum 까지
    SET hap = 0; -- 합
    SET i = startNum; -- i 에 startNum 대입 
    
    WHILE (i <= endNum) DO -- startNum 부터 endNum 까지
		SET hap = hap + i; -- 합 계산
        SET i = i + 1; -- i를 1씩 올림
	END WHILE;
    
    SELECT CONCAT(startNum, ' 부터 ', endNum, ' 까지의 합 ==> ', hap) AS '';
END $$
delimiter ;
CALL whileProc();

DROP PROCEDURE IF EXISTS whileProc2;
delimiter $$
CREATE PROCEDURE whileProc2()
BEGIN
	DECLARE i INT;
    DECLARE hap INT;
    SET i = 1;
    SET hap = 0;
    
    MYWHILE:
    WHILE(1 <= 100) DO
		IF (i % 4 = 0) THEN
			SET i = i + 1;
            ITERATE MYWHILE;
		END IF;
        SET hap = hap + i;
        IF (hap > 1000) THEN
			LEAVE MYWHILE;
		END IF;
			SET i = i + 1;
	END WHILE;
    
    SELECT hap;
END $$
delimiter ;
CALL whileProc2();
