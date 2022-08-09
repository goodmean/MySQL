DROP TABLE IF EXISTS gugutbl;
CREATE TABLE gugutbl(gugu CHAR(5), result CHAR(4));

DROP PROCEDURE IF EXISTS gugudan;
delimiter $$
CREATE PROCEDURE gugudan()
BEGIN
	DECLARE i INT;
	DECLARE j INT;
	DECLARE str CHAR(5);
	DECLARE str1 CHAR(4);
	SET i = 2; -- 몇단부터
	SET j = 1; -- 몇부터 곱할래
	WHILE (i <= 19) DO -- 몇단까지
		SET str = CONCAT(i, '단');
        INSERT INTO gugutbl VALUES(str, NULL);
		WHILE (j <= 19) DO -- 몇까지 곱할래
			SET str = CONCAT(i, 'x', j);
			SET str1 = i*j;
			INSERT INTO gugutbl VALUES(str,str1);
			SET j = j + 1;
		END WHILE;
		SET i = i + 1;
        SET j = 1;
        INSERT INTO gugutbl VALUES(' ', ' ');
	END WHILE;
SELECT * FROM gugutbl;
END $$
delimiter ;

CALL gugudan();