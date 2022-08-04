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
		IF (i % 7 = 0) THEN
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

DROP PROCEDURE IF EXISTS whileProc3;
delimiter $$
CREATE PROCEDURE whileProc3()
BEGIN
	DECLARE i INT; -- 1부터 증가할 변수
    DECLARE sum INT; -- 합계 변수
    SET i = 1; -- 1부터 시작
    SET sum = 0; -- 합계는 0부터 시작
    
    SUMWHILE:
    WHILE (i <= 1000) DO -- 1부터 1000까지 반복
		IF (i%3 != 0 OR i%8 != 0) THEN -- i가 3이나 8의 배수가 아니면
			SET i = i + 1; -- i를 1 증가시키고
            ITERATE SUMWHILE; -- sumWhile 반복문의 다음숫자로 넘어간다
		END IF;
        SET sum = sum + i; -- 위 if문을 통과했다면(3의배수거나 8의배수)합계에 더한다
        SET i = i + 1; -- i는 1씩 증가
	END WHILE;
    SELECT sum '합계'; -- 합계를 출력
END $$
delimiter ;
CALL whileProc3(); -- 함수 실행
