DROP TABLE IF EXISTS gugutbl;
CREATE TABLE gugutbl(gugu CHAR(5), result CHAR(4));

DROP PROCEDURE IF EXISTS gugudan;
delimiter $$
CREATE PROCEDURE gugudan()
BEGIN
	DECLARE i INT;
	DECLARE j INT;
	DECLARE str CHAR(5);
	SET i = 2; -- 몇단부터
	SET j = 1; -- 몇부터 곱할래
	WHILE (i <= 19) DO -- 몇단까지
		SET str = CONCAT(i, '단');
        INSERT INTO gugutbl VALUES(str, NULL);
		WHILE (j <= 19) DO -- 몇까지 곱할래
			SET str = CONCAT(i, 'x', j);
			INSERT INTO gugutbl VALUES(str,i*j);
			SET j = j + 1; -- 곱할 수를 1 증가시킨다
		END WHILE;
		SET i = i + 1; -- 단수를 1 증가시키고
        SET j = 1; -- 곱할 수는 1로 초기화한다.
        INSERT INTO gugutbl VALUES(' ', ' '); -- 한단이 끝나면 한칸 비움.
	END WHILE;
SELECT * FROM gugutbl;
END $$
delimiter ;

CALL gugudan();