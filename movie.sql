drop database if EXISTS moiveDB;
create DATABASE movieDB;
use movieDB;

create table movietbl(
	movie_id int,
    movie_title varchar(30),
    movie_director varchar(20),
    movie_star varchar(20),
    movie_script longtext,
    movie_film longblob
) default charset=utf8mb4;

truncate movietbl;

insert into movietbl values (1, '쉰들러 리스트', '스필버그', '리암 니슨',
	load_file('C:/movie/Schindler.txt'), load_file('c:/movie/Schindler.mp4')
);
insert into movietbl values (2, '쇼생크 탈출', '프랭크 다라본트', '팀 로빈스',
	load_file('C:/movie/Shawshank.txt'), load_file('c:/movie/Shawshank.mp4')
);
insert into movietbl values (3, '라스트 모히칸', '마이클 만', '다니엘 데이 루이스',
	load_file('C:/movie/Mohican.txt'), load_file('c:/movie/Mohican.mp4')
);
select * from movietbl;

select movie_script from movietbl where movie_id=1
	into outfile 'c:/movie/Schindler_out.txt'
    lines TERMINATED BY '\\n';
select movie_film from movietbl where movie_id=3
	into DUMPFILE 'c:/movie/Mohican_out.mp4';
    
show variables like 'max_allowed_packet';
show variables like 'secure_file_priv';
